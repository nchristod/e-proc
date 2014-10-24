class CreateProcurementProducts < ActiveRecord::Migration
  def change
    create_table :procurement_products do |t|

      t.references :procurement
      t.references :product
      t.string :quantity
      t.text :requirements

      t.timestamps
    end
  end
end
