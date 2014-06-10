class Product < ActiveRecord::Base
  belongs_to :procurement
  belongs_to :category
end
