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
