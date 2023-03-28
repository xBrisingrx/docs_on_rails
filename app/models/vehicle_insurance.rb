class VehicleInsurance < ApplicationRecord
  belongs_to :vehicle
  belongs_to :insurance
end
