class Company < ApplicationRecord
	has_many :people 
	has_many :vehicles
	
	validates :name, presence: true, 
		uniqueness: { scope: :d_type, case_sensitive: false, message: "Ya existe una empresa registrada con este nombre" }
	
	enum d_type: {
		people: 1, 
		vehicles: 2
	}

	scope :actives, -> { where(active: true) }
end 