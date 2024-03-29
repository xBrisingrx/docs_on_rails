# == Schema Information
#
# Table name: clothing_packages
#
#  id               :bigint           not null, primary key
#  name             :string(255)      not null
#  description      :text(65535)
#  days_of_validity :integer          default(0), not null
#  expires          :boolean          default(FALSE)
#  active           :boolean          default(TRUE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class ClothingPackage < ApplicationRecord
	has_many :clothes_packs
	has_many :clothes, through: :clothes_packs

	accepts_nested_attributes_for :clothes_packs

	scope :actives, -> { where(active: true) }
	scope :more_than_one_clothes, -> { where(one_clothes: false) }
	def disable current_user
		ActiveRecord::Base.transaction do
			self.clothes_packs.actives.each do |entry|
				entry.update!(active: false)
				ActivityHistory.create( action: :disable, description: "Se quito la prenda #{self.name} del paquete #{entry.clothing_package.name} por dar de baja el paquete.", 
	      record: entry, date: Time.now, user: current_user )
			end
			self.update!(active: false)
		end
	end
end
