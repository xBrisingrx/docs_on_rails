class ListStatesVehicle < ApplicationRecord

	scope :actives, -> { where(active: true) }
end
