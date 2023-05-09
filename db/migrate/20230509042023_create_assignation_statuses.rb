class CreateAssignationStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :assignation_statuses do |t|
      t.integer :d_type
      t.string :name, null: false
      t.string :description
      t.boolean :blocks, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
