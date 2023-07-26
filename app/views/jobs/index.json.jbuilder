json.data @jobs do |job|
	json.name job.name
	json.code job.code
	zones = ''
	if !job.zone_job_profiles.empty?
		zones << '<ul>'
		job.zone_job_profiles.actives.each do |entry|
			zones << "<li>#{entry.zone.name} - #{entry.profile.name}
										#{ link_to '<i class="fa fa-trash"></i>'.html_safe, edit_zone_job_profile_path(entry), remote: true, class: 'btn btn-xs u-btn-red text-white' }
								</li>"
		end
		zones << '</ul>'
	end

	json.zone zones
	if current_user.admin?
		json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_job_path(job), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
									<button class='btn btn-sm u-btn-red text-white' 
	  								title='Eliminar' 
	  								onclick='modal_disable_job( #{ job.id } )'>
										<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
	else
		json.actions ''
	end
end
