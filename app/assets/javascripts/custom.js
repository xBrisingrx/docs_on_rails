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
