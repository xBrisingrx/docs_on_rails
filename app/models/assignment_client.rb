# == Schema Information
#
# Table name: assignment_clients
#
#  id            :bigint           not null, primary key
#  client_id     :bigint
#  assignment_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class AssignmentClient < ApplicationRecord
  belongs_to :client
  belongs_to :assignment
end
