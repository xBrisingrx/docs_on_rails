class ChangeCostCenter < ActiveRecord::Migration[5.2]
  def change
    remove_reference :cost_centers, :unit_business, foreign_key: true
    remove_reference :cost_centers, :function, foreign_key: true
    remove_column :cost_centers, :descripcion

    add_reference :cost_centers, :profile, index: true, foreign_key: true
    add_reference :cost_centers, :job, index: true, foreign_key: true
    add_reference :cost_centers, :zone, index: true, foreign_key: true
  end
end
