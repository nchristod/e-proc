class Offer < ActiveRecord::Base
  attr_encrypted :offer_economical, :key => 'a secret key'
  attr_encrypted :offer_technical, :key => 'another secret key'
  belongs_to :procurement
  belongs_to :user
  belongs_to :product

  has_many :documents, as: :documentable, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true

  validates_presence_of :offer_economical
  validates_presence_of :delivery_date, if: Proc.new { |o| o.procurement.advantageous? }

  # This is reduntant for the moment.
  # Can be used better in future implementations with proper
  # crypto key management systems,
  include Workflow
  workflow do
    state :sealed do
      event :unseal_technical,
            :transitions_to => :technical_evaluation
            # we fake the transitions in controller so this is not really needed
            #, if: proc { |offer| offer.procurement.advantageous? }
    end
    state :technical_evaluation do
      event :unseal_economical, :transitions_to => :unsealed
    end
    state :unsealed
  end

  def is_active?
    self.procurement.proc_end_date >= Date.today
  end

  def expired?
    !self.is_active?
  end

  def self.set_styles
    { encrypted: {
      processors: [:file_encryptor],
      key: File.read("#{Rails.root}/key")}
    }
  end

  def unseal_technical
    self.documents.each { |attachment| attachment.decrypt }
  end

  def unseal_economical
    # do nothing for the moment.
  end

  def econ_tech_eval
    if self.tech_eval
      self.tech_eval / (self.offer_economical.to_i *
        ( 1 + ((self.delivery_date - self.procurement.proc_end_date).to_i/730)))
    else
      "Den exoun ginei texnikes axiologiseis"
    end
  end


end