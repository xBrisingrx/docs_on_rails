json.data @cost_center_documents do |cost_center_document|
	json.cost_center cost_center_document.cost_center.center
	json.zone cost_center_document.cost_center.subcenter
	json.document cost_center_document.document.name
	json.start date_format( cost_center_document.start_date )
	json.end ( !cost_center_document.active ) ? date_format( cost_center_document.end_date ) : ''
	json.status status_format( cost_center_document.active )
	if cost_center_document.active
		json.actions "#{ link_to '<i class="fa fa-trash-o"></i>'.html_safe, modal_disable_cost_center_document_path(cost_center_document), 
                        data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }"
	else
		json.actions "#{ link_to '<i class="fa fa-retweet"></i>'.html_safe, modal_reactive_cost_center_document_path(cost_center_document), 
                        data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-orange text-white', title: 'Reactivar' }"
	end
end