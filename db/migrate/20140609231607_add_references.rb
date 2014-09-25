class AddReferences < ActiveRecord::Migration
  def change
    add_reference :products, :category, index: true
    add_reference :offers, :procurement, index: true
    add_reference :offers, :product, index: true
    add_reference :offers, :user, index: true
  end
end
