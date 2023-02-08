class ZoneJobProfileDoc < ApplicationRecord
  # los perfiles tienen distintos documentos a presentar dependiento 
  # a que puesto laboral este asignado
  # y a que zona 
  belongs_to :zone_job_profile
  has_many :document
  
  has_one :profile, through: :zone_job_profile
  has_one :zone, through: :zone_job_profile
  has_one :job, through: :zone_job_profile
end
