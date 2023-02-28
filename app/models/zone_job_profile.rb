# == Schema Information
#
# Table name: zone_job_profiles
#
#  id         :bigint           not null, primary key
#  zone_id    :bigint
#  job_id     :bigint
#  profile_id :bigint
#  start_date :date
#  end_date   :date
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ZoneJobProfile < ApplicationRecord
  belongs_to :zone
  belongs_to :job
  belongs_to :profile
  has_many :zone_job_profile_docs
  has_many :documents, through: :zone_job_profile_docs

  scope :actives, -> { where(active: true) }

  enum d_type: {
    people: 1, 
    vehicles: 2
  }
  
  def name
    "#{self.job.name} - #{self.zone.name} - #{self.profile.name}"
  end

  def self.profile_type type
    self.joins(:profile)
      .where(profiles: { d_type: type })
  end
end
