# == Schema Information
#
# Table name: cost_centers
#
#  id               :bigint           not null, primary key
#  function_id      :bigint
#  unit_business_id :bigint
#  descripcion      :string(255)
#  active           :boolean          default(TRUE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class CostCenter < ApplicationRecord
  belongs_to :function
  belongs_to :unit_business

  scope :actives, -> { where(active: true) }
  
  def center
    "#{self.function.code}-#{self.unit_business.code}"
  end

  def detail
    "#{self.function.name}-#{self.unit_business.name}"
  end
end
