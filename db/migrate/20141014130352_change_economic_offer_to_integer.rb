class ChangeEconomicOfferToInteger < ActiveRecord::Migration
  def change
    change_column :offers, :offer_economical, :integer
  end
end
