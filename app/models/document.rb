class Document < ApplicationRecord
	# la expiracion la manejo con una tabla expiration_type, en base a esa tabla sacamos cuantos dias vale el documento
	# tengo explicito un campo de dias xq si eligen "personalizado" deben seterar la cantidad de dias a mano
	# en caso de actualizar los dias de cada tipo de expiracion se va a actualizar en todos los documentos
	belongs_to :document_category 
	belongs_to :expiration_type, optional: true

	validates :name, presence: true, 
		uniqueness: { scope: :d_type, case_sensitive: false, message: "Ya existe un atributo registrado con este nombre" }
	validates :d_type, presence: true

	validates :days_of_validity, numericality: { only_integer: true, message: 'Debe ingresar un número.' },
		presence: { message: 'Debe ingresar los días de duración del atributo.' }, if: :document_expire?

	validates :expiration_type_id, presence: { message: 'Seleccione un periodo de vencimiento'}, if: :document_expire?

	validates :end_date, presence: { message: 'Para dar de baja un documento se necesita ingresar la fecha de finalización.'}, if: :document_inactive?

	before_create :set_data_if_no_expire

	enum d_type: {
		people: 1, 
		vehicles: 2
	}

	scope :actives, -> { where(active: true) }

	private 

	def set_data_if_no_expire
		if !self.expires?
			expiration_type = ExpirationType.where(active: false, name: 'No vence').first
			self.expiration_type_id = expiration_type.id
		end
	end

	def document_expire?
		self.expires?
	end

	def document_inactive?
		!self.active
	end

end