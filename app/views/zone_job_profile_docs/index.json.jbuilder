json.data @entries do |entry|
	json.job entry.job.name
	json.zone entry.zone.name
	json.profile entry.profile.name
	json.document entry.document.name
	json.start date_format( entry.start_date )
	json.end date_format( entry.end_date )
	json.status date_format( entry.active )
	json.actions
end