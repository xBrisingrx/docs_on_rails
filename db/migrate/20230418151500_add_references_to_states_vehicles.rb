class AddReferencesToStatesVehicles < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicle_states, :status
    # add_reference :vehicle_states, :list_states_vehicle, foreign_key: true
  end
end
