class AssignmentsDocument < ApplicationRecord
  belongs_to :assignated, polymorphic: true
  belongs_to :document

  validate :unique_association, on: :create

  scope :actives, ->where{ active:true }

  def disable
    if !document_is_shared_with_other_profile? && !self.custom
      self.update!( active: false )
    end
  end

  def document_is_shared_with_other_profile?
    #checkeo si los perfiles que tiene esta persona comparten el atributo
    @count = 0
    self.assignated.assignments_profiles.where(active: true).each do |p|
      if !DocumentsProfile.find_by(profile_id: p.profile_id, document_id: self.document_id, active: true).nil?
        @count +=1
      end
    end
    return @count > 1
  end

  private
  def unique_association
    entry = AssignmentsDocument.find_by(assignated_id: self.assignated_id, assignated_type: self.assignated_type ,document_id: self.document_id)
    if self.id.nil?
      # Validacion para creacion
      if !entry.nil? && entry.active
        errors.add(:uniqueness, "La asignacion ya existe.")
      elsif !entry.nil? && !entry.active
        errors.add(:uniqueness, "La asignacion ya existe, se encuentra dada de baja.")
      end
    end
  end

end
