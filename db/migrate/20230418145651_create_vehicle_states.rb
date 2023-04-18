class CreateVehicleStates < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_states do |t|
      t.references :vehicle, foreign_key: true
      t.references :cost_center, foreign_key: true
      t.references :sub_zone, foreign_key: true
      t.references :operator, foreign_key: true
      t.references :client, foreign_key: true
      t.integer :status
      t.date :start_date
      t.date :end_date
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
