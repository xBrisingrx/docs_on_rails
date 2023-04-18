class SubZone < ApplicationRecord
  belongs_to :geographic_zone

  scope :actives, -> { where(active: true) }
end
