json.extract! vehicle_state, :id, :vehicle_id, :cost_center_id, :sub_zone_id, :status, :operator_id, :client_id, :active, :created_at, :updated_at
json.url vehicle_state_url(vehicle_state, format: :json)
