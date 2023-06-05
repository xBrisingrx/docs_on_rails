json.data @assignment_cost_centers do |assignment_cost_center|
	json.cost_center assignment_cost_center.cost_center.center
	json.subcenter assignment_cost_center.cost_center.subcenter
	json.start_date date_format(assignment_cost_center.start_date)
	json.end_date ( assignment_cost_center.end_date ) ? date_format(assignment_cost_center.end_date) : ''
	json.status assignment_cost_center.assignation_status.name
end