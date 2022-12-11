json.data @companies do |company|
	json.name company.name
	json.description company.description
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_company_path(company), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_company( #{ company.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end
