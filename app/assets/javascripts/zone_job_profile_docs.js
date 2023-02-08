let zone_job_profile_docs_table
$(document).ready(function(){
	zone_job_profile_docs_table = $("#zone_job_profile_docs_table").DataTable({
    'ajax': `zone_job_profile_docs?d_type=${document.getElementById('d_type').value}`,
    'columns': [
    {'data': 'job'},
    {'data': 'zone'},
    {'data': 'profile'},
    {'data': 'document'},
    {'data': 'start'},
    {'data': 'end'},
    {'data': 'status'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-company").on("ajax:success", function(event) {
    companies_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-company").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-company #company_${key}`).addClass('is-invalid')
      $(`#form-company .company_${key}`).text( value ).show('slow')
    })
  })
})