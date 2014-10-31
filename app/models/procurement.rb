class Procurement < ActiveRecord::Base

  enum category: [:underbidding, :advantageous]

  has_many :offers
  has_many :procurement_products, dependent: :delete_all
  has_many :products, through: :procurement_products

  belongs_to :user

  accepts_nested_attributes_for :procurement_products, reject_if: lambda { |a| a[:quantity].blank? }, allow_destroy: true

  validates_presence_of :name, :proc_start_date, :proc_end_date, :proc_delivery_date, :proc_terms
  validate :proc_end_date_valid, :proc_delivery_date_valid

  # Scopes

  scope :expired, -> { where("proc_end_date < ?", Date.today) }
  scope :active, -> { where("proc_end_date > ?", Date.today) }

  # Attachments
  has_many :documents, as: :documentable, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true

  def self.set_styles
    { :original => true }
  end

  def find_best_offers
    if self.underbidding?
      self.products.each do |product|
        best_offers = product.offers.select { |offer| offer.offer_economical == product.offers.minimum(:offer_economical) }
      return best_offers
      end
    else
      best_offers = []
      self.products.each do |product|
        sorted = product.offers.sort { |a,b| a.econ_tech_eval <=> b.econ_tech_eval }
        best_offers = sorted.select { |offer| offer.econ_tech_eval == sorted.last.econ_tech_eval }
      return best_offers
      end
    end
  end

  private
    
    # Custom Validations

    def proc_end_date_valid
      return if self.proc_end_date.blank? || self.proc_start_date.blank?

      if self.proc_end_date <= self.proc_start_date
        errors.add(:proc_end_date, "can't be before or equal with the starting date")
      end
    end

    def proc_delivery_date_valid
      return if self.proc_end_date.blank? || self.proc_delivery_date.blank?
      if self.proc_delivery_date < self.proc_end_date
        errors.add(:proc_delivery_date, "can't be before end date")
      end
    end

end