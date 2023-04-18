class VehicleState < ApplicationRecord
  belongs_to :vehicle
  belongs_to :cost_center
  belongs_to :sub_zone
  belongs_to :list_states_vehicle
  
  belongs_to :operator, optional: true
  belongs_to :client, optional: true

  scope :actives, -> { where(active: true) }

end
