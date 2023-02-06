json.extract! vehicle, :id, :code, :domain, :chassis, :engine, :seats, :year, :vehicle_type_id, :vehicle_model_id, :vehicle_location_id, :active, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
