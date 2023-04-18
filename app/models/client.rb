class Client < ApplicationRecord
	scope :actives, -> { where(active: true) }
end
