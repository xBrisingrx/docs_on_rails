json.extract! people_profile, :id, :person_id, :profile_id, :start_date, :end_date, :active, :created_at, :updated_at
json.url people_profile_url(people_profile, format: :json)
