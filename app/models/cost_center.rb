# == Schema Information
#
# Table name: cost_centers
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :bigint
#  job_id     :bigint
#  zone_id    :bigint
#  d_type     :integer          not null
#
class CostCenter < ApplicationRecord
  # un centro de costos se compone de un perfil, puesto laboral y zona
  # cada centro de acostos tiene asociada documentacion
  # cuando a una unidad/persona se la asgina a un centro de costos , ahi le asignamos los documentos del centro de costos
  belongs_to :profile
  belongs_to :job
  belongs_to :zone
  has_many :cost_center_documents
  has_many :documents, through: :cost_center_documents

  enum d_type: {
    people: 1, 
    vehicles: 2
  }

  validates :profile, uniqueness: { 
    scope: [:job_id, :zone_id],
    message: 'Este centro de costos ya se encuentra registrado' }

  scope :actives, -> { where(active: true) }
  
  def center
    "#{self.job.name} - #{self.profile.name} (#{self.job.code}-#{self.profile.code})"
  end

  def subcenter
    "#{self.zone.name} (#{self.zone.code})"
  end

  def number_center
    "#{self.job.code} - #{self.profile.code}"
  end

  def name_center
    "#{self.job.name} - #{self.profile.name}"
  end

  def self.cost_center_order d_type
    CostCenter.joins(:profile, :job, :zone)
      .where(cost_centers: { d_type: d_type })
      .order('jobs.name ASC, profiles.name ASC')
  end
end
