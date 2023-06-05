class CreateAssignmentOperators < ActiveRecord::Migration[5.2]
  def change
    create_table :assignment_operators do |t|
      t.references :operator, foreign_key: true
      t.references :assignment, foreign_key: true

      t.timestamps
    end
  end
end
