json.data @profiles do |profile|
	json.name profile.name
	json.start_date date_format(profile.start_date)
	json.end_date date_format(profile.end_date)
	json.status status_format(profile.active)
	json.description profile.description
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_profile_path(profile), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_profile( #{ profile.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "

	zone_jobs = ''
	if !profile.zone_job_profiles.empty?
		zone_jobs << '<ul>'
		profile.zone_job_profiles.each do |entry|
			zone_jobs << "<li>#{entry.zone.name} - #{entry.job.name}</li>"
		end
		zone_jobs << '</ul>'
	end

	json.zone_jobs zone_jobs
end


