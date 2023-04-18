class CreateSubZones < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_zones do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :description
      t.boolean :active, default: true
      t.references :geographic_zone, foreign_key: true

      t.timestamps
    end
  end
end
