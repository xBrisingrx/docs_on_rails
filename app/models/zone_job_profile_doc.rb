# == Schema Information
#
# Table name: zone_job_profile_docs
#
#  id                  :bigint           not null, primary key
#  zone_job_profile_id :bigint
#  document_id         :bigint
#  start_date          :date
#  end_date            :date
#  d_type              :integer          not null
#  active              :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class ZoneJobProfileDoc < ApplicationRecord
  # los perfiles tienen distintos documentos a presentar dependiento 
  # a que puesto laboral este asignado
  # y a que zona 
  belongs_to :zone_job_profile
  belongs_to :document
  
  has_one :profile, through: :zone_job_profile
  has_one :zone, through: :zone_job_profile
  has_one :job, through: :zone_job_profile

  enum d_type: {
    people: 1, 
    vehicles: 2
  }

  # after_save :assign_documents

  scope :actives, ->{ where(active:true) }


  def assignment_documents_to_profile 
    entry = ZoneJobProfileDoc.find_by(zone_job_profile_id: self.zone_job_profile_id, document_id: self.document_id)
    if entry.nil? 
      self.save 
    elsif !entry.active?
      entry.update(start_date: self.start_date, active: true)
    else
      raise StandardError.new 'Ya tiene asignado el documento' 
    end
  end

  def update_asociations
    # Si le asigno un documento a un perfil se debe asignar dichos documentos a los asociados
    @documents = ZoneJobProfile.find( self.zone_job_profile_id ).documents
    @assigned_profile = AssignmentsProfile.where(zone_job_profile_id: self.zone_job_profile_id).actives

    ActiveRecord::Base.transaction do
      @assigned_profile.each do |assignated|
        @documents.each do |document|
          @entry = AssignmentsDocument.find_by( assignated_id: assignated.assignated_id, 
            assignated_type: assignated.assignated_type, 
            document_id: document.id)
          if @entry.nil?
            @entry = AssignmentsDocument.create(assignated_id: assignated.assignated_id, assignated_type: assignated.assignated_type, document_id: document.id)
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

  def disable end_date
    ActiveRecord::Base.transaction do
      self.update(active: false, end_date: end_date)
      affected = AssignmentsProfile.where(zone_job_profile_id: self.profile.id, active: true)

      affected.each do |entry|
        # byebug
        puts "\n\n\n shared docs => #{entry.shared_document(self.document_id)} \n\n\n\n"
        if !entry.shared_document(self.document_id)
          puts "\n\n disable #{entry.id} ==== #{self.document_id} \n\n"
          entry_to_disable = AssignmentsDocument.find_by( assignated_id: entry.assignated_id, assignated_type: entry.assignated_type, document_id: self.document_id )
          if !entry_to_disable.custom
            entry_to_disable.update( active: false, end_date: end_date)
          end
        end
      end
    end
  end

  def reactive start_date
    ActiveRecord::Base.transaction do
      self.update(active: true, start_date: start_date)
      affected = AssignmentsProfile.where(zone_job_profile_id: self.profile.id, active: true)
      affected.each do |entry|
        entry_to_reactive = AssignmentsDocument.find_by( assignated_id: entry.assignated_id, assignated_type: entry.assignated_type, document_id: self.document_id )
        if !entry_to_reactive.custom
          entry_to_reactive.update( active: true, start_date: start_date)
        end
      end
    end
  end

end
