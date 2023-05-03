class AddCodeToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :code, :string, limit: 4
  end
end
