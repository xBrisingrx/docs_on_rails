class CreateUnitBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_businesses do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
