class Procurement < ActiveRecord::Base

  has_many :products
  has_many :offers

  belongs_to :user
end
