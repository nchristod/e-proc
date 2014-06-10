class CreateProcurements < ActiveRecord::Migration
  def change
    create_table :procurements do |t|
      t.string :name
      t.datetime :proc_start_date
      t.datetime :proc_end_date
      t.text :proc_terms
      t.datetime :proc_delivery_date
      
      t.timestamps
    end
  end
end
