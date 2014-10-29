class ChangeDateFormatOffers < ActiveRecord::Migration
  def up
    change_column :offers, :delivery_date, :date
  end

  def down
    change_column :offers, :delivery_date, :datetime
  end
end