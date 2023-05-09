# == Schema Information
#
# Table name: assignments_cost_centers
#
#  id                    :bigint           not null, primary key
#  cost_center_id        :bigint
#  assignated_type       :string(255)
#  assignated_id         :bigint
#  operator_id           :bigint
#  client_id             :bigint
#  active                :boolean          default(TRUE)
#  start_date            :date
#  end_date              :date
#  assignation_status_id :bigint
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class AssignmentsCostCenter < ApplicationRecord
  belongs_to :cost_center
  belongs_to :assignated, polymorphic: true
  belongs_to :operator, optional: true
  belongs_to :client, optional: true
  belongs_to :assignation_status

  validate :unique_association, on: :create
  validates :start_date, presence: true

  after_create :assign_documents

  scope :actives, ->{ where(active:true) }
  scope :people, ->{ where( assignated_type: :person ) }
  scope :vehicles, ->{ where( assignated_type: :vehicle ) }


  def assign_documents
    # Si le asigno un perfil a una persona tengo que tambien asociarles los documentos que tiene el perfil
    # Obtengo los documentos que tiene el perfil
    # @documents = DocumentsProfile.where( profile_id: self.profile_id, active: true )
    @documents = CostCenterDocument.where( cost_center_id: self.cost_center_id, active: true )
    ActiveRecord::Base.transaction do
      @documents.each do |document|
        @entry = AssignmentsDocument.find_by( assignated: self.assignated,
          document_id: document.document_id)
        if @entry.nil?
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

  def shared_document document_id
    profiles = AssignmentsCostCenter.where( assignated: self.assignated ).actives
    count = 0
    profiles.each do |profile|
      document = profile.cost_center.cost_center_documents.where(document_id: document_id, active: true)
      puts "\n\n #{ document } \n\n"
      if !document.empty?
        count += 1
      end
    end
    return count > 1
  end

  def disable end_date
    # busco mis documentos asociados al perfil a deshabilitar
    # deshabilito los que se puedan, si se comparte con otro perfil o es custom no se puede
    # deshabilito el perfil
    @documents = CostCenterDocument.where( cost_center_id: self.cost_center_id ).actives
    ActiveRecord::Base.transaction do 
      @documents.each do |document|
        assigned_document = AssignmentsDocument.where( assignated_id: self.assignated_id, 
            assignated_type: self.assignated_type, 
            document_id: document.document_id,
            custom: false)
        if !assigned_document.empty? && !self.shared_document(document.document_id)
          assigned_document.first.update( active: false, end_date: end_date )
        end
      end
      self.update!(active: false, end_date: end_date) 
    end
  end

  def reactive_profile start_date
    @documents = CostCenterDocument.where( cost_center_id: self.cost_center_id ).actives
    ActiveRecord::Base.transaction do 
      @documents.each do |document|
        assigned_document = AssignmentsDocument.where( assignated_id: self.assignated_id, 
            assignated_type: self.assignated_type, 
            document_id: document.document_id)
        if assigned_document.empty?
          AssignmentsDocument.create( assignated: self.assignated, 
            document_id: document.document_id, 
            custom: false,
            start_date: start_date )
        elsif !self.shared_document(document.document_id)
          assigned_document.first.update( active: true )
        end
      end
      self.update!(active: true, start_date: start_date) 
    end
  end

  private
  def unique_association
    @entry = AssignmentsCostCenter.find_by(assignated_id: self.assignated_id, assignated_type: self.assignated_type,
        cost_center_id: self.cost_center_id)
    if self.id.nil? 
      # Validacion para creacion
      if !@entry.nil? && @entry.active
        errors.add(:uniqueness, "La asignacion ya existe.")
      elsif !@entry.nil? && !@entry.active
        errors.add(:uniqueness, "La asignacion ya existe, se encuentra dada de baja.")
      end
    end
  end
end
