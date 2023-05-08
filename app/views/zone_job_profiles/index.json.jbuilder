json.data @zone_job_profiles do |zone_job_profile|
	json.cental_cost "#{zone_job_profile.profile.code} #{zone_job_profile.job.code} - #{zone_job_profile.profile.name} #{zone_job_profile.job.name}"
	json.sub_cental_cost "#{zone_job_profile.zone.code} - #{zone_job_profile.zone.name}"
	json.actions ""
end
