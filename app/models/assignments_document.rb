# == Schema Information
#
# Table name: assignments_documents
#
#  id              :bigint           not null, primary key
#  assignated_type :string(255)
#  assignated_id   :bigint
#  document_id     :bigint
#  start_date      :date
#  end_date        :date
#  custom          :boolean          default(FALSE)
#  active          :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class AssignmentsDocument < ApplicationRecord
  belongs_to :assignated, polymorphic: true
  belongs_to :document
  has_many :document_renovations, dependent: :destroy

  accepts_nested_attributes_for :document_renovations

  # validate :unique_association, on: :create
  validates :document_id, uniqueness: { scope: [:assignated_id, :assignated_type], message: 'El documento ya se encuentra asignado' }

  scope :actives, -> { where(active: true) }

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

  def last_renovation
    self.document_renovations.actives.order(expiration_date: :DESC).first
  end

  def last_renovation_between_dates start_date = nil, end_date = nil
    renovation_date = self.document_renovations.actives

    return '' if renovation_date.blank?

    if !renovation_date.blank? && !self.document.expires?
      return 'Cargado'
    end 
    
    renovation_date = renovation_date.order(expiration_date: :DESC).first

    if renovation_date.blank?
      return '---'
    else
      expiration_date = renovation_date.expiration_date
      if expiration_date.nil?
        return expiration_date
      else
        if !start_date.blank? && !end_date.blank? # buscan los vencimientos de un periodo en especifico
          # buscamos los vencimientos que tenemos en esas fechas 
          if (renovation_date.expiration_date < end_date.to_date && renovation_date.expiration_date > start_date.to_date)
            return expiration_date.strftime('%d-%m-%y')
          else
            return ''
          end
        else
          # devolvemos todos los vencimientos
          return expiration_date.strftime('%d-%m-%y')
        end
      end
    end
  end

  def last_renovation_date
    return '' if !self.document.expires?
    renovation = self.document_renovations.actives.order(expiration_date: :DESC).first
    
    if renovation.blank? || renovation.expiration_date.blank?
      ''
    else
      renovation.expiration_date.strftime('%d-%m-%y')
    end
  end

  def has_renovations?
    self.document_renovations.actives.count > 0
  end

  def assign
    entry = AssignmentsDocument.where(assignated_id: self.assignated_id, assignated_type: self.assignated_type ,document_id: self.document_id)
    if entry.empty?
      self.save
    elsif !entry.first.active 
      entry.update(active: true, custom: self.custom)
    elsif entry.first.active 
      self.errors.add(:base, "Ya tiene asignado este documento.")
    else 
      self.errors.add(:base, "No se puede realizar esta asignacion.")
    end
  end

  def self.acomodo_data
    people = Person.all
    afectados = Array.new
    people.each do |person|
      entries = AssignmentsDocument.where(assignated: person)
      document_ids = entries.pluck(:document_id)
      document_ids = document_ids.select{|element| document_ids.count(element) > 1}
      document_ids.uniq!
      document_ids.each do |document_id|
        assignment_document = entries.where(document_id: document_id)
        if assignment_document.where(active: true)
          assignment_document.where(active: false).destroy_all
          afectados.push(person.id)
        end
      end
    end
    byebug
    # [117, 387, 438, 559, 594, 610, 663, 684, 695, 699, 700, 700, 704, 704, 707, 759, 814, 814, 814, 845, 895, 903, 908, 910, 915, 915, 915, 934, 934, 934, 934, 934]
  end

  private
  def unique_association
    entry = AssignmentsDocument.find_by(assignated_id: self.assignated_id, assignated_type: self.assignated_type ,document_id: self.document_id)
    if !entry.nil? && entry.active
        errors.add(:uniqueness, "Ya tiene asignado este documento.")
    end
  end

end
