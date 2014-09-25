class Procurement < ActiveRecord::Base

  has_many :offers
  has_many :procurement_products
  has_many :products, through: :procurement_products

  belongs_to :user

  validates_presence_of :name, :proc_start_date, :proc_end_date, :proc_delivery_date, :proc_terms
end
