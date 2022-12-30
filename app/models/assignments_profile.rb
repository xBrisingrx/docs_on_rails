class AssignmentsProfile < ApplicationRecord
  belongs_to :assignated, polymorphic: true
  belongs_to :profile

  validate :unique_association
  validates :start_date, presence: true

  after_create :assign_profile

  scope :actives, ->{ where(active:true) }

  def assign_profile
    # Si le asigno un perfil a una persona tengo que tambien asociarles los documentos que tiene el perfil
    # Obtengo los documentos que tiene el perfil
    @documents = DocumentsProfile.where( profile_id: self.profile_id, active: true )
    ActiveRecord::Base.transaction do
      @documents.each do |document|
        @entry = AssignmentsDocument.find_by( assignated_id: self.assignated_id, 
          assignated_type: self.assignated_type, 
          document_id: document.document_id,
          start_date: self.start_date )
        if @entry.nil?
          @entry = AssignmentsDocument.new(assignated_id: self.assignated_id, assignated_type: self.assignated_type, document_id: document.document_id)
          @entry.save
        elsif !@entry.active && !@entry.custom
          # La persona pudo haber tenido un perfil con este documento y se dio de baja la relacion
          # La persona pudo haber tenido un perfil con este documento y al perfil se le quito el documento
          # Los documentos des/asignados manualmente (custom) no se pueden alterar
          @entry.update(active: true) 
        end
      end
    end
  end

  private
  def unique_association
    @entry = AssignmentsProfile.find_by(assignated_id: self.assignated_id, assignated_type: self.assignated_type ,profile_id: self.profile_id)
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
