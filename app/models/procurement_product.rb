class ProcurementProduct < ActiveRecord::Base

  belongs_to :procurements
  belongs_to :products

end
