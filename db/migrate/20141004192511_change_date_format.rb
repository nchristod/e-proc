class ChangeDateFormat < ActiveRecord::Migration
  def up
    change_column :procurements, :proc_end_date, :date
    change_column :procurements, :proc_start_date, :date
    change_column :procurements, :proc_delivery_date, :date
  end

  def down
    change_column :procurements, :proc_end_date, :datetime
    change_column :procurements, :proc_start_date, :datetime
    change_column :procurements, :proc_delivery_date, :datetime
  end

end
