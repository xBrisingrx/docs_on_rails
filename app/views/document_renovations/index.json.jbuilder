json.data @document_renovations do |renovation|
	json.renovation_date date_format(renovation.renovation_date)
	json.expiration_date date_format(renovation.expiration_date)
	if renovation.file.attached?
		json.file "#{ link_to 'pdf', document_renovation_show_files_path( document_renovation_id: renovation.id), class: 'btn u-btn-indigo', remote: true }"
	else
		json.file 'none'
	end
	json.actions 'btns'
end