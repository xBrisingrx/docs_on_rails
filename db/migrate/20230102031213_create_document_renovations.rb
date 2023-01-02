class CreateDocumentRenovations < ActiveRecord::Migration[5.2]
  def change
    create_table :document_renovations do |t|
      t.references :assignments_document, foreign_key: true
      t.date :renovation_date, null: false
      t.date :expiration_date, null: false
      t.boolean :active, default: true
      t.string :comment

      t.timestamps
    end
  end
end
