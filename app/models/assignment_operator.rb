# == Schema Information
#
# Table name: assignment_operators
#
#  id            :bigint           not null, primary key
#  operator_id   :bigint
#  assignment_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class AssignmentOperator < ApplicationRecord
  belongs_to :operator
  belongs_to :assignment
end
