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

  def status_asignation
    green = '32CD32'
    red = 'FF0000'
    orange = 'FF4500'

    status = self.expires_documents
    if status == green
      icon = 'fa-thumbs-up'
      color = 'green'
    end
    if status == orange
      icon = 'fa-certificate'
      color = 'orange'
    end
    if status == red
      icon = 'fa-warning'
      color = 'red'
    end

    "<span class='u-label g-rounded-20 g-bg-#{color} g-px-10 g-mr-5 g-mb-10'><i class='fa #{icon} g-mr-3'></i></span>"
  end

  def document_by_cost_center
    documents = Array.new

    self.cost_center.documents.actives.order(:name).map { |document|
      renovation = self.assignated.assignments_documents.find_by( assignated: self.assignated, document_id: document.id ).last_renovation
      if renovation.blank?
        expiration_date = 'No esta cargado'
        expires = '<span class="u-label g-bg-lightred g-rounded-3 g-mr-10 g-mb-15">No esta cargado</span>'
      else
        if document.expires?
          expiration_date = renovation.expiration_date.strftime('%d-%m-%y')
          status_renovation = days_to_expire_document( renovation.expiration_date )
          if status_renovation >= 30
            expires = '<span class="u-label g-bg-green g-rounded-3 g-mr-10 g-mb-15">Correcto</span>'
          elsif status_renovation >= 1 && status_renovation < 30
            expires = '<span class="u-label g-bg-orange g-rounded-3 g-mr-10 g-mb-15">Próximo a vencer</span>'
          else
            expires = '<span class="u-label g-bg-lightred g-rounded-3 g-mr-10 g-mb-15">Vencido</span>'
          end
          
        else
          expiration_date = 'Cargado'
          expires = '<span class="u-label g-bg-green g-rounded-3 g-mr-10 g-mb-15">Cargado</span>'
        end
      end
      documents << {
        name: document.name,
        expiration_date: expiration_date,
        expires: expires
      }
    }
    documents
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

  def expires_documents
    # vemos si tiene algun documento vencido o por vencer en esta asignacion
    green = '32CD32'
    yellow = 'FFFF00'
    orange = 'FF4500'
    red = 'FF0000'
    white = 'FFFFFF'
    today = Date.today
    proximo_a_vencer = 0
    self.cost_center.documents.actives.map { |document|
      renovation = self.assignated.assignments_documents.find_by( assignated: self.assignated, document_id: document.id ).last_renovation
      if !renovation.blank?
        if renovation.document.expires?
          status_document = self.days_to_expire_document(renovation.expiration_date)
          if status_document >= 16 && status_document <= 30 
            proximo_a_vencer += 1
          end

          if status_document < 16
            return red 
          end
        end
      else
        return red
      end
    }
    if proximo_a_vencer >= 1
      return orange
    else 
      return green
    end
  end

  def days_to_expire_document date
    today = Date.today
    # expire_date = Date.parse(date)
    diff = date.to_date - today

    diff
  end

end
