let vehicle_states_table

function modal_disable_vehicle_state(id) {
  clean_form('form-disable-vehicle_state')
  setInputDate('#form-disable-vehicle_state #date')
  $('.select-2-reasons').val(''); // Select the option with a value of '1'
  $('.select-2-reasons').trigger('change'); // Notify any JS components that the value changed
  $('#modal-disable-vehicle_state #vehicle_state_id').val(id)
  $('#modal-disable-vehicle_state').modal('show')
}

$(document).ready(function(){
  vehicle_states_table = $("#vehicle_states_table").DataTable({
    'ajax': 'vehicle_states',
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


  $('.select-2-reasons').select2({ width: '50%',theme: "bootstrap4", placeholder: "Seleccione motivo (*)" })

  $("#form-disable-vehicle-state").on("ajax:success", function(event) {
    vehicle_states_table.ajax.reload(null,false)
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