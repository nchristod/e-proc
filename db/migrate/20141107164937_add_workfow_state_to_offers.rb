class AddWorkfowStateToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :workflow_state, :string
  end
end
