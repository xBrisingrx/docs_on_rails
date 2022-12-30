class AssignmentsDocument < ApplicationRecord
  belongs_to :assignated, polymorphic: true
  belongs_to :document

  scope :actives, ->where{ active:true }
end
