class Procurement < ActiveRecord::Base

  enum category: [:underbidding, :advantageous]

  has_many :offers
  has_many :procurement_products, dependent: :delete_all
  has_many :products, through: :procurement_products

  belongs_to :user

  accepts_nested_attributes_for :procurement_products, reject_if: lambda { |a| a[:quantity].blank? }, allow_destroy: true

  validates_presence_of :name, :proc_start_date, :proc_end_date, :proc_delivery_date, :proc_terms
end