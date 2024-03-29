json.data @people do |person|
	json.file person.file
	json.name person.fullname 
	json.dni person.dni 
	if !person.activity_histories.blank? && person.activity_histories.last.action == 3
		json.reason person.activity_histories.last.reasons_to_disable.reason
	else
		json.reason ''
	end
	json.date (!person.activity_histories.blank?) ? date_format(person.activity_histories.last.date) : ''
	json.actions "#{ link_to '<i class="fa fa-eye"></i>'.html_safe, show_person_history_path(id: person.id), 
                  class: 'btn u-btn-blue btn-sm',  data: {toggle: 'tooltip'}, title: 'Ver historial', remote: true }  	
                #{ link_to '<i class="fa fa-refresh"></i>'.html_safe, modal_enable_person_path(id: person.id), 
                  class: 'btn u-btn-orange btn-sm',  data: {toggle: 'tooltip'}, title: 'Reactivar', remote: true }"
end