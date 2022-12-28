json.extract! documents_profile, :id, :profile_id, :document_id, :active, :created_at, :updated_at
json.url documents_profile_url(documents_profile, format: :json)
