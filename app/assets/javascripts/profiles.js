let profiles_table
let profiles_type = ''
function modal_disable_profile(id) {
  $('#modal-disable-profile #profile_id').val(id)
  $('#modal-disable-profile').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('profiles_d_type') != undefined ) {
    profiles_type = document.getElementById('profiles_d_type').value
  }
	profiles_table = $("#profiles_table").DataTable({
    'ajax': `profiles?d_type=${profiles_type}`,
    'columns': [
    {'data': 'name'},
    {'data': 'start_date'},
    {'data': 'description'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-profile").on("ajax:success", function(event) {
    profiles_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-profile").modal('hide')
  }).on("ajax:error", function(event) {
    noty_alert(msj.status, msj.msg)
  })
})

