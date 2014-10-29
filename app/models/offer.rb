class Offer < ActiveRecord::Base

  belongs_to :procurement
  belongs_to :user
  belongs_to :product

  has_many :documents, as: :documentable, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true

# validate only one offer per user per procurement
def unique_for_procurement
  
end

def econ_tech_eval
  if self.tech_eval
    self.tech_eval / (self.offer_economical * ( 1 + ((self.delivery_date - self.procurement.proc_end_date).to_i/730)))
  else
    "Den exoun ginei texnikes axiologiseis"
  end
end 

  
end
