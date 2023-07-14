json.data @assignments do |assignment|
	json.code "#{ link_to assignment.status_asignation.html_safe, document_by_cost_center_assignments_path( id: assignment.id ), remote: true }#{assignment.assignated.code}"
	json.domain assignment.assignated.domain 
	json.status assignment.assignation_status.name
	json.start_date date_format(assignment.start_date)
	json.end_date date_format(assignment.end_date)
	json.company assignment.assignated.company.name 
	json.cost_center assignment.cost_center.center
	json.sub_center assignment.cost_center.subcenter
	
	operators = '<ul>'
	assignment.operators.map{|operator| operators += "<li>#{operator.name}</li>"}
	operators += '</li>'
	json.operator operators

	clients = '<ul>'
	assignment.clients.map{|client| clients += "<li>#{client.name}</li>"}
	clients += '</li>'
	json.client clients
end