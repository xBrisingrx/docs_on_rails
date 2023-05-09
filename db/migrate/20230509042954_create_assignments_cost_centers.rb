class CreateAssignmentsCostCenters < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments_cost_centers do |t|
      t.references :cost_center, foreign_key: true
      t.references :assignated, polymorphic: true, index: { name: 'index_assigment_cc' }
      t.references :operator, foreign_key: true
      t.references :client, foreign_key: true
      t.boolean :active, default: true
      t.date :start_date
      t.date :end_date
      t.references :assignation_status, foreign_key: true

      t.timestamps
    end
  end
end
