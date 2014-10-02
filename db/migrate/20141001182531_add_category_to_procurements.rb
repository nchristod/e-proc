class AddCategoryToProcurements < ActiveRecord::Migration
  def change
    add_column :procurements, :category, :integer
  end
end
