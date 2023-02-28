json.data @entries do |entry|
	json.job entry.job.name
	json.zone entry.zone.name
	json.profile entry.profile.name
	json.document entry.document.name
	json.start date_format( entry.start_date )
	json.end date_format( entry.end_date )
	json.status status_format( entry.active )
	json.actions "#{ link_to '<i class="fa fa-trash-o"></i>'.html_safe, modal_disable_zone_job_profile_docs_path(entry), 
                        data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }"
end