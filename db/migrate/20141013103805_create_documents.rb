class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :documentable, polymorphic: true, index: true
      t.string :document_file_name
      t.integer :document_file_size
      t.string :document_content_type
      t.datetime :document_updated_at
      t.string :document_fingerprint

      t.timestamps
    end
  end
end
