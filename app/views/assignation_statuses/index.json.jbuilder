json.data @assignation_statuses do |assignation_status|
	json.name assignation_status.name
	json.description assignation_status.description
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_assignation_status_path(assignation_status), 
										remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_assignation_status( #{ assignation_status.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end
