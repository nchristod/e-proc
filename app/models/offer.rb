class Offer < ActiveRecord::Base

  belongs_to :procurement
  belongs_to :user
  belongs_to :product

  has_many :documents, as: :documentable, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true

  # Worklow
  # workflow do
  #   state :active do
  #     event :submit, :transitions_to => :awaiting_review
  #   end
  #   state :awaiting_review do
  #     event :review, :transitions_to => :being_reviewed
  #   end
  #   state :being_reviewed do
  #     event :accept, :transitions_to => :accepted
  #     event :reject, :transitions_to => :rejected
  #   end
  #   state :accepted
  #   state :rejected
  # end

  def is_active?
    self.procurement.proc_end_date > Date.today
  end 

  def expired?
    !self.is_active?
  end

  def self.set_styles
    { encrypted: {processors: [:file_encryptor], key: File.read("#{Rails.root}/key")} }
  end

  def econ_tech_eval
    if self.tech_eval
      self.tech_eval / (self.offer_economical * ( 1 + ((self.delivery_date - self.procurement.proc_end_date).to_i/730)))
    else
      "Den exoun ginei texnikes axiologiseis"
    end
  end 

  
end