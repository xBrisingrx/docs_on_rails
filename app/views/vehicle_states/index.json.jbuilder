json.data @vehicle_states do |vehicle_state|
	json.code vehicle_state.vehicle.code
	json.domain vehicle_state.vehicle.domain 
	json.status vehicle_state.assignation_status.name
	json.start_date date_format(vehicle_state.start_date)
	json.end_date date_format(vehicle_state.end_date)
	json.company vehicle_state.vehicle.company.name 
	json.cost_center vehicle_state.cost_center.center
	json.sub_center vehicle_state.sub_zone.name 
	
	operators = '<ul>'
	vehicle_state.operators.map{|operator| operators += "<li>#{operator.name}</li>"}
	operators += '</li>'
	json.operator operators

	clients = '<ul>'
	vehicle_state.clients.map{|client| clients += "<li>#{client.name}</li>"}
	clients += '</li>'
	json.client clients
end

