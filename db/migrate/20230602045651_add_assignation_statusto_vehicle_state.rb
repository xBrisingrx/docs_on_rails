class AddAssignationStatustoVehicleState < ActiveRecord::Migration[5.2]
  def up
    remove_reference :vehicle_states, :list_states_vehicle
    add_reference :vehicle_states, :assignation_status, foreign_key: true
  end

  def down
    remove_reference :vehicle_states, :assignation_status
    add_reference :vehicle_states, :list_states_vehicle, foreign_key: true
  end
end
