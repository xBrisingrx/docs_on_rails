class AddCompanyToPerson < ActiveRecord::Migration[5.2]
  def change
    add_reference :people, :company, foreign_key: true
  end
end
