json.data @jobs do |job|
	json.name job.name
	json.description job.description

	zones = ''
	if !job.zone_job_profiles.empty?
		zones << '<ul>'
		job.zone_job_profiles.each do |entry|
			zones << "<li>#{entry.zone.name} - #{entry.profile.name}</li>"
		end
		zones << '</ul>'
	end

	json.zone zones
	json.actions "#{ link_to '<i class="fa fa-plus"></i>'.html_safe, new_zone_job_profile_path(job_id: job.id, d_type: job.d_type), remote: :true, 
										class: 'btn btn-sm u-btn-purple text-white', title: 'Asignar zona y perfiles' }
								#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_job_path(job), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_jobs( #{ job.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end
