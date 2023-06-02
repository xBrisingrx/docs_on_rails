class VehicleStateClient < ApplicationRecord
  belongs_to :vehicle_state
  belongs_to :client

  has_one :vehicle, through: :vehicle_state
end
