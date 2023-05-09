json.data @zones do |zone|
	json.code zone.code
	json.name zone.name
	json.description zone.description
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, 
										edit_zone_path(zone), 
										remote: :true, 
										class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' }"
end
