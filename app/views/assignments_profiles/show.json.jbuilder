json.data @profiles do |profile|
	json.profile profile.zone_job_profile.name
	json.start_date date_format(profile.start_date)
	json.end_date ( profile.active ) ? '' : date_format(profile.end_date)
	 json.status status_format( profile.active )
end