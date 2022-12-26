class DocumentCategory < ApplicationRecord
	validates :name, presence: true, 
		uniqueness: { message: "Ya existe una categoría registrada con este nombre" }
	scope :actives, -> { where(active: true) }
end
