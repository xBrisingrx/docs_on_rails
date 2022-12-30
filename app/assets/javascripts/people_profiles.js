let people_profiles_table
let people_profiles_type = ''


$(document).ready(function(){
	people_profiles_table = $("#people_profiles_table").DataTable({
    'ajax': 'people_profiles',
    'columns': [
    {'data': 'last_name'},
    {'data': 'name'},
    {'data': 'dni'},
    {'data': 'profile'},
    {'data': 'start_date'},
    {'data': 'end_date'},
    {'data': 'status'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})
})