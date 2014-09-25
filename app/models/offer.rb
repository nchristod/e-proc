class Offer < ActiveRecord::Base

  belongs_to :procurement
  belongs_to :user
  belongs_to :product
  
end
