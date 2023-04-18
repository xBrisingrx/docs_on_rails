let cost_centers_table

function modal_disable_cost_center(id) {
  $('#modal-disable-cost_center #cost_center_id').val(id)
  $('#modal-disable-cost_center').modal('show')
}

$(document).ready(function(){
	cost_centers_table = $("#cost_centers_table").DataTable({
    'ajax': `cost_centers`,
    'columns': [
    {'data': 'center'},
    {'data': 'detail'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-cost_center").on("ajax:success", function(event) {
    cost_centers_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-cost_center").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-cost_center #cost_center_${key}`).addClass('is-invalid')
      $(`#form-cost_center .cost_center_${key}`).text( value ).show('slow')
    })
  })
})

