# == Schema Information
#
# Table name: zones
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Zone < ApplicationRecord
	validates :name, presence: true, 
		uniqueness: { case_sensitive: false, message: "Ya existe una zona registrada con este nombre" }

	validates :code, presence: true,
	uniqueness: { case_sensitive: false, message: "Ya existe una zona registrada con este código" },
	format: {
    with: /\A[0-9]+\z/,
    message: "Solo puede ingresar números"
  }

	scope :actives, -> { where(active: true) }
end
