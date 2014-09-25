class Product < ActiveRecord::Base
  belongs_to :procurement
  belongs_to :category

  validates_presence_of :category_id, :name
end
