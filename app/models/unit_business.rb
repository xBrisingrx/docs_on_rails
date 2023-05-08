# == Schema Information
#
# Table name: unit_businesses
#
#  id          :bigint           not null, primary key
#  code        :string(255)      not null
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class UnitBusiness < ApplicationRecord
	scope :actives, -> { where(active: true) }
end
