# == Schema Information
#
# Table name: companies
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  d_type      :integer          not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Company < ApplicationRecord
	has_many :people 
	has_many :vehicles
	
	validates :name, presence: true, 
		uniqueness: { scope: :d_type, case_sensitive: false, message: "Ya existe una empresa registrada con este nombre" }
	
	enum d_type: {
		people: 1, 
		vehicles: 2
	}

	scope :actives, -> { where(active: true) }
end 
