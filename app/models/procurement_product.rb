class ProcurementProduct < ActiveRecord::Base

  belongs_to :procurement, inverse_of: :procurement_product
  belongs_to :product

end
