class AddDefaultValueToDaysOfValidity < ActiveRecord::Migration[5.2]
  def change
    change_column :documents, :days_of_validity, :integer, default: 1
    change_column :documents, :allow_modify_expiration, :integer, default: false
  end
end
