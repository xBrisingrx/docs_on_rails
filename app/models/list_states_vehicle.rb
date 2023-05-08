# == Schema Information
#
# Table name: list_states_vehicles
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ListStatesVehicle < ApplicationRecord

	scope :actives, -> { where(active: true) }
end
