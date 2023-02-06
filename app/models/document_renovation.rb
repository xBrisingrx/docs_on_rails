# == Schema Information
#
# Table name: document_renovations
#
#  id                      :bigint           not null, primary key
#  assignments_document_id :bigint
#  renovation_date         :date
#  expiration_date         :date
#  active                  :boolean          default(TRUE)
#  comment                 :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class DocumentRenovation < ApplicationRecord
	has_many_attached :file

	scope :actives, ->{ where(active:true) }
end
