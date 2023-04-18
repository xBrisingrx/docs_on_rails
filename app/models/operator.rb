class Operator < ApplicationRecord

	scope :actives, -> { where(active: true) }
end
