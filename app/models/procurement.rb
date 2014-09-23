class Procurement < ActiveRecord::Base

  has_many :products
  has_many :offers

  belongs_to :user

  validates_presence_of :name, :proc_start_date, :proc_end_date, :proc_delivery_date, :proc_terms
end
