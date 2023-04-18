class CreateCostCenters < ActiveRecord::Migration[5.2]
  def change
    create_table :cost_centers do |t|
      t.references :function, foreign_key: true
      t.references :unit_business, foreign_key: true
      t.string :descripcion
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
