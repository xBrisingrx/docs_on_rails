# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  d_type      :integer
#  name        :string(255)      not null
#  start_date  :date
#  end_date    :date
#  description :string(255)
#  active      :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Profile < ApplicationRecord
	has_many :documents_profile
	has_many :documents, through: :documents_profile
	has_many :zone_job_profiles
	has_many :zones, through: :zone_job_profiles
	has_many :jobs, through: :zone_job_profiles
	
	validates :name, presence: true, 
		uniqueness: { scope: :d_type, case_sensitive: false, message: "Ya existe un perfil registrado con este nombre" }
	validates :end_date, presence: { message: 'Para dar de baja un perfil se necesita ingresar la fecha de finalización.'}, if: :profile_inactive?
	validates :d_type, presence: true

	enum d_type: {
		people: 1, 
		vehicles: 2
	}
	scope :actives, -> { where(active: true) }

	def disable end_date
		ActiveRecord::Base.transaction do
			self.zone_job_profiles.each do |zone_job_profile|
				zone_job_profile.disable(end_date)
			end
		end
		self.update(active: false, end_date: end_date)
	end

	private
	def profile_inactive?
		self.active == false
	end
end
