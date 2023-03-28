# json.data @documents do |document|
# 	json.document document.document.name
# 	json.category document.document.document_category.name
# 	json.expire document.document.expires? ? 'Si' : 'No'
# 	json.expire_date (document.last_renovation) ? date_format(document.last_renovation.expiration_date) : ''
	
# 	if !document.last_renovation.nil?
# 		json.expire_date show_files(document.last_renovation)
# 	else
# 		json.file "<p><i class='fa fa-file-pdf-o fa-2x'></i></p>"
# 	end

# 	if document.has_renovations?
# 		json.actions  "#{ link_to '<i class="fa fa-eye"></i>'.html_safe, document_renovations_path( assignments_document_id: document.id ), 
#                   					class: 'btn u-btn-orange btn-sm',  
#                   					data: {toggle: 'tooltip'}, title: 'Ver renovaciones', remote: true }
#                   	#{ link_to '<i class="fa fa-trash"></i>'.html_safe, 
#                   		modal_disable_assignments_documents_path(id: document.id), 
#                         data: {toggle: 'tooltip'}, remote: :true, 
#                         class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }
#                   "
# 	else
# 		json.actions  "#{ link_to '<i class="fa fa-plus"></i>'.html_safe, document_renovations_path( assignments_document_id: document.id ), 
#                   					class: 'btn u-btn-indigo btn-sm',  
#                   					data: {toggle: 'tooltip'}, title: 'Ver renovaciones', remote: true }
#                   #{ link_to '<i class="fa fa-trash"></i>'.html_safe, 
#                   		modal_disable_assignments_documents_path(id: document.id), 
#                         data: {toggle: 'tooltip'}, remote: :true, 
#                         class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }"
# 	end
# end
json.data @array do |document|
	json.document document[:document]
	json.category document[:category]
	json.expire document[:expire]
	json.expire_date document[:expire_date]
	
	if !document[:last_renovation]
		json.expire_date show_files(document[:last_renovation])
	else
		json.file "<p><i class='fa fa-file-pdf-o fa-2x'></i></p>"
	end

	if document[:custom]
		json.actions document[:actions]	
	end
	
	if document[:has_renovations] && !document[:custom]
		json.actions  "#{ link_to '<i class="fa fa-eye"></i>'.html_safe, document_renovations_path( assignments_document_id: document[:id] ), 
                  					class: 'btn u-btn-orange btn-sm',  
                  					data: {toggle: 'tooltip'}, title: 'Ver renovaciones', remote: true }
                  	#{ link_to '<i class="fa fa-trash"></i>'.html_safe, 
                  		modal_disable_assignments_documents_path(id: document[:id]), 
                        data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }
                  "
	elsif !document[:has_renovations] && !document[:custom]
		json.actions  "#{ link_to '<i class="fa fa-plus"></i>'.html_safe, document_renovations_path( assignments_document_id: document[:id] ), 
                  					class: 'btn u-btn-indigo btn-sm',  
                  					data: {toggle: 'tooltip'}, title: 'Ver renovaciones', remote: true }
                  #{ link_to '<i class="fa fa-trash"></i>'.html_safe, 
                  		modal_disable_assignments_documents_path(id: document[:id]), 
                        data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }"
	end
end