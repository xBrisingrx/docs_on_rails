class UnitBusiness < ApplicationRecord
	scope :actives, -> { where(active: true) }
end
