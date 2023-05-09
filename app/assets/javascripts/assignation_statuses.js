let assignation_statuses_table

function modal_disable_assignation_status(id) {
  $('#modal-disable-assignation_status #assignation_status_id').val(id)
  $('#modal-disable-assignation_status').modal('show')
}

$(document).ready(function(){
  $("#form-disable-assignation-status").on("ajax:success", function(event) {
    assignation_statuses_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-assignation_status").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-assignation_status #assignation_status_${key}`).addClass('is-invalid')
      $(`#form-assignation_status .assignation_status_${key}`).text( value ).show('slow')
    })
  })
})