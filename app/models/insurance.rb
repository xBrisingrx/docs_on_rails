class Insurance < ApplicationRecord
	has_many :vehicle_insurances
	has_many :vehicles, through: :vehicle_insurances

	accepts_nested_attributes_for :vehicle_insurances

	validates :name, presence: true, 
		uniqueness: { case_sensitive: false, message: "Ya existe una aseguradora registrada con este nombre" }

	scope :actives, -> { where(active: true) }
end
