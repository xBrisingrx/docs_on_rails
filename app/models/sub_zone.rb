# == Schema Information
#
# Table name: sub_zones
#
#  id                 :bigint           not null, primary key
#  code               :string(255)      not null
#  name               :string(255)      not null
#  description        :string(255)
#  active             :boolean          default(TRUE)
#  geographic_zone_id :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class SubZone < ApplicationRecord
  belongs_to :geographic_zone

  scope :actives, -> { where(active: true) }
end
