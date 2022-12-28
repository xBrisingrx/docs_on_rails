class DocumentsProfile < ApplicationRecord
  # Documents in profile
  belongs_to :profile
  belongs_to :document

  validate :unique_association, on: :create

  validates :end_date, presence: { message: 'Para dar de baja un documento se necesita ingresar la fecha de finalización.'}, if: :document_profile_inactive?
  
  scope :actives, -> { where(active: true) }

  enum d_type: {
    people: 1, 
    vehicles: 2
  }
  
  private 

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
