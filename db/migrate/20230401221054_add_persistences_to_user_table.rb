class AddPersistencesToUserTable < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :name, :string, null: false
    change_column :users, :username, :string, null: false
    change_column :users, :email, :string, null: false
    change_column :users, :rol, :integer, default: 2
    change_column :users, :active, :boolean, default: true
  end
end
