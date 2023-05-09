let vehicles_cost_centers_table

function modal_disable_vehicles_cost_center(id) {
  clean_form('form-disable-vehicle-cost-center')
  setInputDate('#form-disable-vehicle-cost-center #date')
  $('.select-2-reasons').val(''); // Select the option with a value of '1'
  $('.select-2-reasons').trigger('change'); // Notify any JS components that the value changed
  $('#modal-disable-vehicle-cost-center #vehicles_cost_center_id').val(id)
  $('#modal-disable-vehicle-cost-center').modal('show')
}

$(document).ready(function(){
  vehicles_cost_centers_table = $("#vehicles_cost_centers_table").DataTable({
    'ajax': 'vehicles_cost_centers',
    'columns': [
    {'data': 'code'},
    {'data': 'domain'},
    {'data': 'status'},
    {'data': 'company'},
    {'data': 'cost_center'},
    {'data': 'sub_center'},
    {'data': 'operator'},
    {'data': 'client'},
    {'data': 'start_date'},
    {'data': 'end_date'}
    ],
    'language': {'url': datatables_lang}
  })


  $('.select-2-reasons').select2({ width: '50%',theme: "bootstrap4", placeholder: "Seleccione motivo (*)" })

  $("#form-disable-vehicle-cost-center").on("ajax:success", function(event) {
    vehicles_cost_centers_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-vehicle-cost-center").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-vehicle-cost-center #vehicles_cost_center_${key}`).addClass('is-invalid')
      $(`#form-vehicle-cost-center .vehicles_cost_center_${key}`).text( value ).show('slow')
    })
  })

})