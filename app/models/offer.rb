class Offer < ActiveRecord::Base
  belongs_to :procurement
  belongs_to :user
end
