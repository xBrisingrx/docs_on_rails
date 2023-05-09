json.data @cost_centers do |cost_center|
	json.center cost_center.center
	json.subcenter cost_center.subcenter
	json.actions "<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_cost_center( #{ cost_center.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end
