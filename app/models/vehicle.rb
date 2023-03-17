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
  has_many :assignments_profiles, as: :assignated # relacion entre perfil y vehiculo
  has_many :profiles, through: :assignments_profiles
  has_many :assignments_documents, as: :assignated
  has_many :documents, through: :assignments_documents
  has_many :activity_histories, as: :record
  has_many_attached :images

  scope :actives, -> { where(active: true) }
  
  def brand
    self.vehicle_model.vehicle_brand.name
  end

  def disable end_date
    ActiveRecord::Base.transaction do
      self.update(active: false)
      self.assignments_profiles.where(active: true).update_all(active:false, end_date: end_date)
      self.assignments_documents.where(active: true).update_all(active:false, end_date: end_date)
    end

    rescue => e
      puts "Oops. We tried to do an invalid operation! #{e}"
  end
end
