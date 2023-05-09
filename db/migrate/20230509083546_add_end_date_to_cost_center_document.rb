class AddEndDateToCostCenterDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :cost_center_documents, :end_date, :date
  end
end
