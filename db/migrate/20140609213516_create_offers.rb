class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.text :offer_technical
      t.text :offer_economical
      t.datetime :delivery_date

      t.timestamps
    end
  end
end
