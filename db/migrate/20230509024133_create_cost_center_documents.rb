class CreateCostCenterDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :cost_center_documents do |t|
      t.references :cost_center, foreign_key: true
      t.references :document, foreign_key: true
      t.date :start_date
      t.integer :d_type, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
