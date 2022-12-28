let documents_profiles_table
let documents_profiles_type = ''
function modal_disable_profile(id) {
  $('#modal-disable-profile #profile_id').val(id)
  setInputDate('#form-disable-profile #end_date')
  $('#form-disable-profile #end_date').removeClass('is-invalid')
  $('#form-disable-profile .end_date').text('')
  $('#modal-disable-profile').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('d_type') != undefined ) {
    documents_profiles_type = document.getElementById('d_type').value
  }
	documents_profiles_table = $("#documents_profiles_table").DataTable({
    'ajax': `documents_profiles?d_type=${documents_profiles_type}`,
    'columns': [
    {'data': 'profile'},
    {'data': 'document'},
    {'data': 'start_date'},
    {'data': 'end_date'},
    {'data': 'status'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-profile").on("ajax:success", function(event) {
    documents_profiles_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-profile").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    $.each( msg, function( key, value ) {
      $('#form-disable-profile #end_date').addClass('is-invalid')
      $('#form-disable-profile .end_date').text( value ).show('slow')
    })
  })
})