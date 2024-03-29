class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.references :assignated, polymorphic: true
      t.references :cost_center, foreign_key: true
      t.references :assignation_status, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
