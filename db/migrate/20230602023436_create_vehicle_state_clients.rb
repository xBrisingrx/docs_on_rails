class CreateVehicleStateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_state_clients do |t|
      t.references :vehicle_state, foreign_key: true
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
