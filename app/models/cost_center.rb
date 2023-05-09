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
  belongs_to :profile
  belongs_to :job
  belongs_to :zone

  enum d_type: {
    people: 1, 
    vehicles: 2
  }

  scope :actives, -> { where(active: true) }
  
  def center
    "#{self.profile.name}-#{self.job.name} (#{self.profile.code}-#{self.job.code})"
  end

  def subcenter
    "#{self.zone.name} (#{self.zone.code})"
  end
end
