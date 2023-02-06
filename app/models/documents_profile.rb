# == Schema Information
#
# Table name: documents_profiles
#
#  id          :bigint           not null, primary key
#  d_type      :integer          not null
#  profile_id  :bigint
#  document_id :bigint
#  start_date  :date
#  end_date    :date
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class DocumentsProfile < ApplicationRecord
  # Documents in profile
  belongs_to :profile
  belongs_to :document

  validate :unique_association, on: :create

  validates :end_date, presence: { message: 'Para dar de baja un documento se necesita ingresar la fecha de finalización.'}, if: :document_profile_inactive?
  
  scope :actives, -> { where(active: true) }

  after_create :assign_document 

  enum d_type: {
    people: 1, 
    vehicles: 2
  }
  
  private 

  def assign_document
    # Si al perfil se le agregar un documento hay que revisar los registros asociados
    assginateds = AssignmentsProfile.where( profile_id: self.profile_id )
    ActiveRecord::Base.transaction do
      assginateds.each do |assignated|
        entry = AssignmentsDocument.find_by( assignated_id: assignated.assignated_id, 
                                             assignated_type: assignated.assignated_type,
                                             document_id: self.document_id )
        if entry.nil?
          assignated_document = AssignmentsDocument.create(assignated_id: assignated.assignated_id, 
                                             assignated_type: assignated.assignated_type,
                                             document_id: self.document_id)
        elsif !entry.custom && !entry.active
          entry.update( active: true )
        end
      end
    end
  end

  def document_profile_inactive?
    self.active == false
  end

  def unique_association
    # este error deberia disparar una ventana q pregunte si quieren reactivar la asociacion
    # lo puse sobre campo active para identificar el error a la hora de mostarlo en pantalla
    @entry = DocumentsProfile.find_by(profile_id: self.profile_id, document_id: self.document_id)
    if !@entry.nil? && @entry.active
      errors.add(:uniqueness, "Este perfil ya tiene asignado el atributo.")
      # self.errors[:base] << "El perfil ya tiene este atributo"
    elsif !@entry.nil? && !@entry.active
      errors.add(:base, "Este perfil ya tiene asignado el atributo, se encuentra dado de baja")
    end
  end
  
end
