class AddReferences < ActiveRecord::Migration
  def change
    add_reference :procurements, :user, index: true
    add_reference :products, :procurement, index: true
    add_reference :products, :category, index: true
    add_reference :offers, :procurement, index: true
    add_reference :offers, :user, index: true
  end
end
