# == Schema Information
#
# Table name: assignments_profiles
#
#  id              :bigint           not null, primary key
#  assignated_type :string(255)
#  assignated_id   :bigint
#  profile_id      :bigint
#  start_date      :date
#  end_date        :date
#  active          :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class AssignmentsProfile < ApplicationRecord
  belongs_to :assignated, polymorphic: true
  belongs_to :zone_job_profile
  has_one :profile, through: :zone_job_profile
  has_many :documents, through: :profile

  validate :unique_association, on: :create
  validates :start_date, presence: true

  after_create :assign_profile

  scope :actives, ->{ where(active:true) }

  def assign_profile
    # Si le asigno un perfil a una persona tengo que tambien asociarles los documentos que tiene el perfil
    # Obtengo los documentos que tiene el perfil
    # @documents = DocumentsProfile.where( profile_id: self.profile_id, active: true )
    @document = ZoneJobProfileDoc.where( zone_job_profile: self.zone_job_profile, active: true )
    ActiveRecord::Base.transaction do
      @documents.each do |document|
        @entry = AssignmentsDocument.find_by( assignated_id: self.assignated_id, 
          assignated_type: self.assignated_type, 
          document_id: document.document_id,
          start_date: self.start_date )
        if @entry.nil?
          @entry = AssignmentsDocument.create(assignated_id: self.assignated_id, assignated_type: self.assignated_type, document_id: document.document_id)
        elsif !@entry.active && !@entry.custom
          # La persona pudo haber tenido un perfil con este documento y se dio de baja la relacion
          # La persona pudo haber tenido un perfil con este documento y al perfil se le quito el documento
          # Los documentos des/asignados manualmente (custom) no se pueden alterar
          @entry.update(active: true)
        end
      end
    end
  end

  # def get_documents
  #   # obtener los documentos asociados al asinado de este perfil
  #   AssignmentsDocument.select('documents.id ,documents.name')
  #                        .where( assignated_id: self.assignated_id, assignated_type: self.assignated_type, active: true )
  #                        .where( "documents_profiles.profile_id = ?", self.profile_id )
  #                         .joins( "INNER JOIN documents_profiles ON documents_profiles.document_id = assignments_documents.document_id" )
  #                         .joins( "INNER JOIN documents ON documents.id = assignments_documents.document_id" )
  #                           .group("document_id").order(:name)
  # end

  def shared_document document_id
    # If the assigned has this document in more the one active profile , I can't disable
    query = AssignmentsProfile.select("assignments_profiles.id,documents_profiles.document_id as document_id,COUNT(documents_profiles.document_id) as count_documents")
                        .where("assignments_profiles.active = true")
                        .where("assignments_profiles.assignated_id = ?", self.assignated_id)
                        .where("assignments_profiles.assignated_type = ?", self.assignated_type.to_sym)
                        .where("documents_profiles.document_id = ?", document_id)
                          .joins("INNER JOIN documents_profiles ON documents_profiles.profile_id = assignments_profiles.profile_id")
                            .group("documents_profiles.document_id").first
    query.count_documents > 1
  end

  def disable end_date
    # busco mis documentos asociados al perfil a deshabilitar
    # deshabilito los que se puedan, si se comparte con otro perfil o es custom no se puede
    # deshabilito el perfil
    @documents = DocumentsProfile.where( profile_id: self.profile_id ).actives
    ActiveRecord::Base.transaction do 
      @documents.each do |document|
        assigned_document = AssignmentsDocument.find_by( assignated_id: self.assignated_id, 
            assignated_type: self.assignated_type, 
            document_id: document.document_id,
            custom: false,
            active: true)
        if !assigned_document.nil?
          assigned_document.disable
        end
      end
      self.update!(active: false, end_date: end_date) 
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
