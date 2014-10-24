class Offer < ActiveRecord::Base

  belongs_to :procurement
  belongs_to :user
  belongs_to :product

  has_many :documents, as: :documentable, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true
  
end
