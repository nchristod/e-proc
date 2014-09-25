class Product < ActiveRecord::Base

  has_many :offers
  has_many :procurement_products
  has_many :procurements, through: :procurement_products
  belongs_to :category

  validates_presence_of :category_id, :name
end
