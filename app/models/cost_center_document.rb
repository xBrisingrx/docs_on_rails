# == Schema Information
#
# Table name: cost_center_documents
#
#  id             :bigint           not null, primary key
#  cost_center_id :bigint
#  document_id    :bigint
#  start_date     :date
#  d_type         :integer          not null
#  active         :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class CostCenterDocument < ApplicationRecord
  belongs_to :cost_center
  belongs_to :document

  scope :actives, -> { where(active: true) }

  def assignment_document
    entry = CostCenterDocument.find_by(cost_center_id: self.cost_center_id, document_id: self.document_id)
    if entry.nil? 
      self.save 
    elsif !entry.active?
      entry.update(start_date: self.start_date, active: true)
    else
      raise StandardError.new "El documento #{entry.document.name} ya se encuentra asignado"
    end
  end


  def update_asociations
    # Si le asigno un documento a un perfil se debe asignar dichos documentos a los asociados
    @documents = CostCenter.find( self.cost_center_id ).documents
    @assigned_cost_center = AssignmentsCostCenter.where(cost_center_id: self.cost_center_id).actives

    ActiveRecord::Base.transaction do
      @assigned_cost_center.each do |assignated|
        @documents.each do |document|
          @entry = AssignmentsDocument.find_by( assignated: assignated.assignated, 
            document: document)
          if @entry.nil?
            @entry = AssignmentsDocument.create(assignated: assignated.assignated, document: document)
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
      affected = AssignmentsCostCenter.where(cost_center_id: self.cost_center_id, active: true)

      affected.each do |entry|
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
      affected = AssignmentsCostCenter.where(cost_center_id: self.cost_center_id, active: true)
      affected.each do |entry|
        entry_to_reactive = AssignmentsDocument.find_by( assignated_id: entry.assignated_id, assignated_type: entry.assignated_type, document_id: self.document_id )
        if !entry_to_reactive.custom
          entry_to_reactive.update( active: true, start_date: start_date)
        end
      end
    end
  end

end
