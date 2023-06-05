class CreateAssignmentClients < ActiveRecord::Migration[5.2]
  def change
    create_table :assignment_clients do |t|
      t.references :client, foreign_key: true
      t.references :assignment, foreign_key: true

      t.timestamps
    end
  end
end
