# == Schema Information
#
# Table name: assignation_statuses
#
#  id          :bigint           not null, primary key
#  d_type      :integer
#  name        :string(255)      not null
#  description :string(255)
#  blocks      :boolean          default(FALSE)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class AssignationStatus < ApplicationRecord
	# son los estados de las asignaciones
	# hay estados que se pueden compartir, eso depende del atributo blocks
	# Ej. si una unidad esta asignada a mantenimiento, en esas fechas no puede ser asignada a otro lugar
	
	validates :name, presence: true, 
		uniqueness: { scope: :d_type, case_sensitive: false, message: "Este estado ya se encuentra registrado" }
	validates :d_type, presence: true

	scope :actives, -> { where(active: true) }

	enum d_type: {
    people: 1, 
    vehicles: 2
  }

end
