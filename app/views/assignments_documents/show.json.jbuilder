json.data @documents do |document|
	json.document document.document.name
	json.category document.document.document_category.name
	json.expire document.document.expires? ? 'Si' : 'No'
	json.expire_date (document.last_renovation) ? date_format(document.last_renovation.expiration_date) : ''
	if !document.last_renovation.nil? && document.last_renovation.file.attached?
		json.file "#{link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, 
									document_renovation_show_files_path( document_renovation_id: document.last_renovation.id), remote:true}"
	else
		json.file "<p><i class='fa fa-file-pdf-o fa-2x'></i></p>"
	end
	
	if document.has_renovations?
		json.actions  "#{ link_to '<i class="fa fa-eye"></i>'.html_safe, document_renovations_path( assignments_document_id: document.id ), 
                  					class: 'btn u-btn-orange btn-sm',  
                  					data: {toggle: 'tooltip'}, title: 'Ver renovaciones', remote: true }"
	else
		json.actions  "#{ link_to '<i class="fa fa-plus"></i>'.html_safe, document_renovations_path( assignments_document_id: document.id ), 
                  					class: 'btn u-btn-indigo btn-sm',  
                  					data: {toggle: 'tooltip'}, title: 'Ver renovaciones', remote: true }"
	end
end