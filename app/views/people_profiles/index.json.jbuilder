json.data @people_profiles do |person_profile|
    json.name person_profile.assignated.name
    json.last_name person_profile.assignated.last_name
    json.dni person_profile.assignated.dni
    json.profile person_profile.zone_job_profile.name
    json.start_date date_format(person_profile.start_date)
    json.end_date date_format(person_profile.end_date)
    json.status status_format( person_profile.active )
    json.actions ''
end