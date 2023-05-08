let zone_job_profile = {
	count_zone_profile: 0,
  errors: ''
}

function modal_disable_zone_job_profile(id) {
  $('#modal-disable-zone-job-profile #zone_job_profile_id').val(id)
  $('#modal-disable-zone-job-profile').modal('show')
}

$(document).ready(function(){
  zone_job_profiles_table = $("#zone_job_profiles_table").DataTable({
    'ajax': `zone_job_profiles?d_type=${document.getElementById('d_type').value}`,
    'columns': [
    {'data': 'cental_cost'},
    {'data': 'sub_cental_cost'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })
})