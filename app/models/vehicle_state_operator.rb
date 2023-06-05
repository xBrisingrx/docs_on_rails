# == Schema Information
#
# Table name: vehicle_state_operators
#
#  id               :bigint           not null, primary key
#  vehicle_state_id :bigint
#  operator_id      :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class VehicleStateOperator < ApplicationRecord
  belongs_to :vehicle_state
  has_one :vehicle, through: :vehicle_state
  belongs_to :operator
end
