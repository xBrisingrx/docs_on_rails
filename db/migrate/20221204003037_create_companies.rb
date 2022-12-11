class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.integer :d_type, null: false
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
