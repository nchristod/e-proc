class CreateProcurementProducts < ActiveRecord::Migration
    create_join_table :procurements, :products, table_name: :procurement_products do |t|

      t.string :quantity
      t.text :requirements

      t.timestamps
    end
end
