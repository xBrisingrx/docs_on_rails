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
end
