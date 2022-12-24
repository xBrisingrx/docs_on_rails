class Profile < ApplicationRecord
	validates :name, presence: true, 
		uniqueness: { scope: :d_type, case_sensitive: false, message: "Ya existe un perfil registrado con este nombre" }
	
	enum d_type: {
		people: 1, 
		vehicles: 2
	}
	scope :actives, -> { where(active: true) }
end
