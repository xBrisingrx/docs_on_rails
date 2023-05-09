json.data @vehicle_states do |vehicle_state|
	json.code vehicle_state.vehicle.code
	json.domain vehicle_state.vehicle.domain 
	json.status vehicle_state.list_states_vehicle.name
	json.company vehicle_state.vehicle.company.name 
	json.cost_center ''
	json.sub_center vehicle_state.sub_zone.name 
	json.operator vehicle_state.operator&.name 
	json.client vehicle_state.client&.name 
end

