class AddTechEvalToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :tech_eval, :integer
  end
end
