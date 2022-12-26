class ExpirationType < ApplicationRecord
	validates :name, presence: true, 
		uniqueness: { message: "Ya existe un tipo de expiración registrado con este nombre" }
	scope :actives, -> { where(active: true) }
end
