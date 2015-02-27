class RenameEncryptedFieldsToOffers < ActiveRecord::Migration
  def up
    change_table :offers do |t|
      t.remove :offer_economical
      t.rename :offer_technical, :encrypted_offer_technical
      t.string :encrypted_offer_economical
    end
  end

  def down
    change_table :offers do |t|
      t.remove :encrypted_offer_economical
      t.remove :encrypted_offer_technical
      t.string :offer_economical
      t.text :offer_technical
    end
  end
end
