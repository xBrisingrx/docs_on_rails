class Profile < ApplicationRecord
	has_many :documents_profile
	has_many :documents, through: :documents_profile
	validates :name, presence: true, 
		uniqueness: { scope: :d_type, case_sensitive: false, message: "Ya existe un perfil registrado con este nombre" }

	validates :end_date, presence: { message: 'Para dar de baja un perfil se necesita ingresar la fecha de finalización.'}, if: :profile_inactive?
	enum d_type: {
		people: 1, 
		vehicles: 2
	}
	scope :actives, -> { where(active: true) }

	private
	def profile_inactive?
		self.active == false
	end
end
