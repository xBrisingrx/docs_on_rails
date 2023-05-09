# == Schema Information
#
# Table name: jobs
#
#  id          :bigint           not null, primary key
#  d_type      :integer          not null
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  code        :string(4)
#
class Job < ApplicationRecord
	has_many :zone_job_profiles
	has_many :zones, through: :zone_job_profiles
	has_many :profiles, through: :zone_job_profiles

	validates :d_type, presence: true
	validates :code, presence: true,
		uniqueness: { case_sensitive: false, message: "Ya existe una puesto laboral registrada con este código" },
		format: {
	    with: /\A[0-9]+\z/,
	    message: "Solo puede ingresar números"
	  }
	  
	enum d_type: {
		people: 1, 
		vehicles: 2
	}

	scope :actives, -> { where(active: true) }
	
	def disable
		ActiveRecord::Base.transaction do
			self.zone_job_profiles.each do |zone_job_profile|
				zone_job_profile.disable( Time.now )
			end
			self.update(active:false)
		end
	end
	
end
