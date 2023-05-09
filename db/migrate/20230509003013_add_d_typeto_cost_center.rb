class AddDTypetoCostCenter < ActiveRecord::Migration[5.2]
  def change
    add_column :cost_centers, :d_type, :integer, null:false
  end
end
