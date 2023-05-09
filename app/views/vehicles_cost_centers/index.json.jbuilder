json.data @vehicles_cost_centers do |vehicle_cost_center|
  json.code vehicle_cost_center.assignated.code
  json.domain vehicle_cost_center.assignated.domain 
  json.status vehicle_cost_center.assignation_status.name
  json.company vehicle_cost_center.assignated.company.name 
  json.cost_center vehicle_cost_center.cost_center.center 
  json.sub_center vehicle_cost_center.cost_center.subcenter 
  json.operator vehicle_cost_center.operator&.name 
  json.client vehicle_cost_center.client&.name 
  json.start_date (vehicle_cost_center.start_date) ? date_format(vehicle_cost_center.start_date) : ''
  json.end_date (vehicle_cost_center.end_date) ? date_format(vehicle_cost_center.end_date) : ''
end
