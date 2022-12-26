let documents_table
let documents_type = ''
function modal_disable_document(id) {
  $('#modal-disable-document #document_id').val(id)
  setInputDate('#form-disable-document #end_date')
  $('#form-disable-document #end_date').removeClass('is-invalid')
  $('#form-disable-document .end_date').text('')
  $('#modal-disable-document').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('documents_d_type') != undefined ) {
    documents_type = document.getElementById('documents_d_type').value
  }
	documents_table = $("#documents_table").DataTable({
    'ajax': `documents?d_type=${documents_type}`,
    'columns': [
    {'data': 'name'},
    {'data': 'description'},
    {'data': 'category'},
    {'data': 'expires'},
    {'data': 'expiration_type'},
    {'data': 'days_of_validity'},
    {'data': 'allow_modify_expiration'},
    {'data': 'observations'},
    {'data': 'renewal_methodology'},
    {'data': 'monthly_summary'},
    {'data': 'start_date'},
    {'data': 'end_date'},
    {'data': 'status'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-document").on("ajax:success", function(event) {
    documents_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-document").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    $.each( msg, function( key, value ) {
      $('#form-disable-document #end_date').addClass('is-invalid')
      $('#form-disable-document .end_date').text( value ).show('slow')
    })
  })
})

