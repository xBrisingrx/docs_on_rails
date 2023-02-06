class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.integer :d_type, null:false
      t.string :name, null:false
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
