class VehicleStateOperator < ApplicationRecord
  belongs_to :vehicle_state
  has_one :vehicle, through: :vehicle_state
  belongs_to :operator
end
