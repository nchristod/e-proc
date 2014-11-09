class AddBestOfferIdToProcurementProducts < ActiveRecord::Migration
  def change
    add_column :procurement_products, :best_offer_id, :integer
  end
end
