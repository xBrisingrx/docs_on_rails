# == Schema Information
#
# Table name: clients
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Client < ApplicationRecord
	scope :actives, -> { where(active: true) }
end
