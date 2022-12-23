const datatables_lang = "/assets/vendor/datatables/datatables_lang_spa.json";

function noty_alert(type, message, time = 7000) {
  const newNoty = new Noty({
    type: type,
    layout: "topRight",
    timeout: (true, time),
    text: message,
    theme: "bootstrap-v4",
    closeWith: ['click', 'button'],
  }).show();
}

function set_input_status_form( form_id, object_name, msg ){
  // form_id es el id del form
  // object_name es el nombre del modelo 
  let inputs = document.querySelectorAll(`#${form_id} .form-control`)
  let list_ids = []
  for (let i = 0; i< inputs.length; i++) {
      list_ids[i] = inputs[i].id
  }
  $.each( msg, function( key, value ) {
    $(`#${form_id} #${object_name}_${key}`).addClass('is-invalid')
    $(`#${form_id} .${object_name}_${key}`).text( value ).show('slow')
    list_ids = list_ids.filter( element => element != `${object_name}_${key}`)
  })

  for (let i = list_ids.length - 1; i >= 0; i--) {
    let input = document.querySelector(`#${form_id} #${list_ids[i]}`)
    input.classList.remove('is-invalid')
    document.querySelector(`#${form_id} .${list_ids[i]}`).textContent = ''

    if ( input.value != '' ) {
      input.classList.add('is-valid')
    }
    
    if ( input.value == '' ) {
      input.classList.remove('is-valid')
    }
  }
}
