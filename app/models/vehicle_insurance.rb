class VehicleInsurance < ApplicationRecord
  belongs_to :vehicle
  belongs_to :insurance
  has_many_attached :file
end
