class CreateOperators < ActiveRecord::Migration[5.2]
  def change
    create_table :operators do |t|
       t.string :name, null: false
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
