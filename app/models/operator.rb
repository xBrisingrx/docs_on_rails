# == Schema Information
#
# Table name: operators
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Operator < ApplicationRecord

	scope :actives, -> { where(active: true) }
end
