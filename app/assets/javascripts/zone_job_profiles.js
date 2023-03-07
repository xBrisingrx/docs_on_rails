let zone_job_profile = {
	count_zone_profile: 0,
}

function modal_disable_zone_job_profile(id) {
  $('#modal-disable-zone-job-profile #zone_job_profile_id').val(id)
  $('#modal-disable-zone-job-profile').modal('show')
}