class Function < ApplicationRecord
	scope :actives, -> { where(active: true) }
end
