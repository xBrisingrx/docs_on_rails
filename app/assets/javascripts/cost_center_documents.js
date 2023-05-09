let cost_center_documents_table
let cost_center_document = {
  count_documents: 0
}
let cost_target;
$(document).ready(function(){
	cost_center_documents_table = $("#cost_center_documents_table").DataTable({
    'ajax': `cost_center_documents?d_type=${document.getElementById('d_type').value}`,
    'columns': [
    {'data': 'cost_center'},
    {'data': 'zone'},
    {'data': 'document'},
    {'data': 'start'},
    {'data': 'end'},
    {'data': 'status'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})
})