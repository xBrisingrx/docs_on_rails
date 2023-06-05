let assignments_vehicles_table

function modal_disable_vehicle_state(id) {
  clean_form('form-disable-vehicle_state')
  setInputDate('#form-disable-vehicle_state #date')
  $('.select-2-reasons').val(''); // Select the option with a value of '1'
  $('.select-2-reasons').trigger('change'); // Notify any JS components that the value changed
  $('#modal-disable-vehicle_state #vehicle_state_id').val(id)
  $('#modal-disable-vehicle_state').modal('show')
}

$(document).ready(function(){
  assignments_vehicles_table = $("#assignments_vehicles_table").DataTable({
    'order': false,
    'ajax': '/assignments/vehicles',
    'columns': [
    {'data': 'code'},
    {'data': 'domain'},
    {'data': 'status'},
    {'data': 'start_date'},
    {'data': 'end_date'},
    {'data': 'company'},
    {'data': 'cost_center'},
    {'data': 'sub_center'},
    {'data': 'operator'},
    {'data': 'client'}
    ],
    'language': {'url': datatables_lang}
  })

  $("#form-disable-assignment").on("ajax:success", function(event) {
    assignments_vehicles_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-vehicle-state").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-vehicle-state #vehicle_state_${key}`).addClass('is-invalid')
      $(`#form-vehicle-state .vehicle_state_${key}`).text( value ).show('slow')
    })
  })

})