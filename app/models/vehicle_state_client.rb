# == Schema Information
#
# Table name: vehicle_state_clients
#
#  id               :bigint           not null, primary key
#  vehicle_state_id :bigint
#  client_id        :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class VehicleStateClient < ApplicationRecord
  belongs_to :vehicle_state
  belongs_to :client

  has_one :vehicle, through: :vehicle_state
end
