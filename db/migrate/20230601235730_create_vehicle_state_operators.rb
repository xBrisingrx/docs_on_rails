class CreateVehicleStateOperators < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_state_operators do |t|
      t.references :vehicle_state, foreign_key: true
      t.references :operator, foreign_key: true

      t.timestamps
    end
  end
end
