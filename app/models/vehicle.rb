# == Schema Information
#
# Table name: vehicles
#
#  id                  :bigint           not null, primary key
#  code                :string(255)      not null
#  domain              :string(255)
#  chassis             :string(255)
#  engine              :string(255)
#  seats               :string(255)
#  year                :integer
#  observations        :text(65535)
#  active              :boolean          default(TRUE)
#  vehicle_type_id     :bigint
#  vehicle_model_id    :bigint
#  vehicle_location_id :bigint
#  company_id          :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Vehicle < ApplicationRecord
  belongs_to :vehicle_type
  belongs_to :vehicle_model
  belongs_to :vehicle_location
  belongs_to :company

  scope :actives, -> { where(active: true) }
  
  def brand
    self.vehicle_model.vehicle_brand.name
  end
end
