class AddCodeToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :code, :string, limit: 4
  end
end
