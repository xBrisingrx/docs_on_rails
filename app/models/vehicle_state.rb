# == Schema Information
#
# Table name: vehicle_states
#
#  id                     :bigint           not null, primary key
#  vehicle_id             :bigint
#  cost_center_id         :bigint
#  sub_zone_id            :bigint
#  operator_id            :bigint
#  client_id              :bigint
#  start_date             :date
#  end_date               :date
#  active                 :boolean          default(TRUE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  list_states_vehicle_id :bigint
#
class VehicleState < ApplicationRecord
  belongs_to :vehicle
  belongs_to :cost_center
  belongs_to :sub_zone
  belongs_to :list_states_vehicle
  
  belongs_to :operator, optional: true
  belongs_to :client, optional: true

  scope :actives, -> { where(active: true) }

end
