class Assignment < ApplicationRecord
  # Las asignaciones son cuando a una unidad/persona se la asigna a un centro de costos
  # Eso quiere decir que se la envia a un lugar a cubrir un trabajo por un tiempo determinado
  # Depende el estado de la asignacion puede o no estar asignado a mas de un lugar en el mismo periodo de tiempo
  belongs_to :assignated, polymorphic: true
  belongs_to :cost_center
  belongs_to :assignation_status
  has_many :assignment_clients, dependent: :destroy
  has_many :assignment_operators, dependent: :destroy
  has_many :clients, through: :assignment_clients
  has_many :operators, through: :assignment_operators

  accepts_nested_attributes_for :assignment_clients, :assignment_operators

  validates :start_date, presence: !:end_date.blank?
  validates :end_date, presence: !:start_date.blank?
  validate :is_available_to_assignment, :valid_dates, :create_assignment_with_blocked_state

  after_create :assign_documents
  # before_validation :set_sub_zone

  scope :actives, -> { where(active: true) }
  scope :for_vehicles, -> { where(assignated_type: 'Vehicle') }
  scope :for_poeple, -> { where(assignated_type: 'Person') }

  def shared_document document_id
    assignments = Assignment.where( assignated: self.assignated ).where( 'end_date >=' , Time.now.to_date).actives
    count = 0
    assignments.each do |assignment|
      document = assignment.cost_center.cost_center_documents.where(document_id: document_id, active: true)
      if !document.empty?
        count += 1
      end
    end
    return count > 1
  end

  def self.check_dates(assignated_type, assignated_id, start_date, end_date)
    state = Assignment.where( assignated_type: assignated_type ,assignated_id: assignated_id )
    state.where('start_date BETWEEN ? AND ?', start_date, end_date)
      .or(Assignment.where(assignated_type: assignated_type ,assignated_id: assignated_id).where('end_date BETWEEN ? AND ?', start_date, end_date))
  end

  private
  def is_available_to_assignment #verifico la unidad/persona se encuentra bloqueado en esas fechas
    blocked = Assignment
              .where( assignated: self.assignated )
              .where('assignments.start_date BETWEEN ? AND ?', self.start_date, self.end_date)
              .or( Assignment.where('assignments.end_date BETWEEN ? AND ?', self.start_date, self.end_date) )
              .joins(:assignation_status)
              .where('assignation_statuses': { blocks: true })
    if !blocked.blank?
      errors.add(:start_date, "La unidad se encuentra #{blocked.assignation_status.name} en estas fechas")
      errors.add(:end_date, "La unidad se encuentra #{blocked.assignation_status.name} en estas fechas")
    end
  end

  def create_assignment_with_blocked_state 
    # se quiere asignar la unidad/persona con un estado bloqueante
    # hay que veriticar que no este asignado a otro lugar en estas fechas
    state = AssignationStatus.find(self.assignation_status_id)
    if state.blocks?
      blocked = Assignment
              .where( assignated: self.assignated )
              .where('assignments.start_date BETWEEN ? AND ?', self.start_date, self.end_date)
              .or(Assignment.where('assignments.end_date BETWEEN ? AND ?', self.start_date, self.end_date))
              .joins(:assignation_status)
      if !blocked.blank?
        errors.add(:start_date, "La unidad se encuentra asignada en esas fechas")
        errors.add(:end_date, "La unidad se encuentra asignada en esas fechas")
        errors.add(:base, "No puede asignar al vehiculo un estado que bloquea si se encuentra asignado en esas fechas")
      end
    end
  end

  def valid_dates
    errors.add(:start_date, "La fecha de inicio no puede ser mayor a la de fin") if self.start_date > self.end_date
  end

  def assign_documents
    # La asignacion tiene asociada un centro de costos, ese centro tiene los documentos que debe tener
    # la unidad/persona para cumplir con la asignacion
    # Obtengo los documentos que tiene el centro de costos
    @documents = CostCenterDocument.where( cost_center_id: self.cost_center_id, active: true )
    ActiveRecord::Base.transaction do
      @documents.each do |document|
        @entry = AssignmentsDocument.find_by( assignated: self.assignated,
          document_id: document.document_id)
        if @entry.blank?
          AssignmentsDocument.create(assignated: self.assignated, document_id: document.document_id, start_date: self.start_date)
        elsif !@entry.active && !@entry.custom
          # La persona pudo haber tenido un perfil con este documento y se dio de baja la relacion
          # La persona pudo haber tenido un perfil con este documento y al perfil se le quito el documento
          # Los documentos des/asignados manualmente (custom) no se pueden alterar
          @entry.update(active: true)
        end
      end
    end
  end

end
