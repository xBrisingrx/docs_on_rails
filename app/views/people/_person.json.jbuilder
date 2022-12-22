json.extract! person, :id, :file, :name, :last_name, :dni, :dni_has_expiration, :date_expiration_dni, :birth_date, :nationality, :direction, :phone, :date_start_activity, :active, :company_id, :created_at, :updated_at
json.url person_url(person, format: :json)
