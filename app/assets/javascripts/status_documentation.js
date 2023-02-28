let assignments_person_profiles, assignments_person_documents
const status_documentation = {
	populate_with_peron_data: ()=> {
	let person_id = document.getElementById("person_select").value
	document.getElementById('assignated_id').value = person_id
	fetch(`/people/${person_id}`)
		.then( response => {
			return response.json()
		})
		.then( data => {
			document.getElementById("person_start_activity").innerHTML = `Inicio actividad: ${data.start_activity} ==`
			document.getElementById("person_dni").innerHTML = `DNI: ${data.dni} `
			document.getElementById("person_cuil").innerHTML = `CUIL: ${data.cuil}`
			document.getElementById("person_birth_date").innerHTML = `Fecha de nacimiento: ${data.birth_date}`
			document.getElementById("person_nationality").innerHTML = `Nacionalidad: ${data.nationality}`
			document.getElementById("person_direction").innerHTML = `Direcion: ${data.direction}`
			document.getElementById("person_phone").innerHTML = `Telefono: ${data.phone}`

			if (data.dni_file != '') {
				document.getElementById("person_dni_file").innerText = 'Ver archivo'
				document.getElementById("person_dni_file").setAttribute('data-remote', 'false')
				document.getElementById("person_dni_file").setAttribute('target', '_blank')
				document.getElementById("person_dni_file").href = data.dni_file
			} else {
				document.getElementById("person_dni_file").innerText = 'Cargar PDF'
				document.getElementById("person_dni_file").setAttribute('target', '')
				document.getElementById("person_dni_file").setAttribute('data-remote', 'true')
				document.getElementById("person_dni_file").href = `/people/${data.id}/upload_person_file/dni_file?file_name=DNI`
			}

			if (data.cuil_file != '') {
				document.getElementById("person_cuil_file").innerText = 'Ver archivo'
				document.getElementById("person_cuil_file").setAttribute('data-remote', 'false')
				document.getElementById("person_cuil_file").setAttribute('target', '_blank')
				document.getElementById("person_cuil_file").href = data.cuil_file
			} else {
				document.getElementById("person_cuil_file").innerText = 'Cargar PDF'
				document.getElementById("person_cuil_file").setAttribute('target', '')
				document.getElementById("person_cuil_file").setAttribute('data-remote', 'true')
				document.getElementById("person_cuil_file").href = `/people/${data.id}/upload_person_file/cuil_file?file_name=CUIL`
			}

			if (data.start_activity_file != '') {
				document.getElementById("person_start_activity_file").innerText = 'Ver archivo'
				document.getElementById("person_start_activity_file").setAttribute('data-remote', 'false')
				document.getElementById("person_start_activity_file").setAttribute('target', '_blank')
				document.getElementById("person_start_activity_file").href = data.start_activity_file
			} else {
				document.getElementById("person_start_activity_file").innerText = 'Cargar PDF'
				document.getElementById("person_start_activity_file").setAttribute('target', '')
				document.getElementById("person_start_activity_file").setAttribute('data-remote', 'true')
				document.getElementById("person_start_activity_file").href = `/people/${data.id}/upload_person_file/start_activity_file?file_name=CUIL`
			}

			$('#person_information').show('slow')
			document.getElementById("form_people_documentation").reset()
			assignments_person_profiles.ajax.url(`/assignments_profiles/${person_id}?assignated=person`)
			assignments_person_profiles.ajax.reload(null,false)
			
			assignments_person_documents.ajax.url(`/assignments_documents/${person_id}?assignated=person`)
			assignments_person_documents.ajax.reload(null,false)
		})
		.catch( error => {
			console.log('Hubo un problema con la petición Fetch:' + error.message);
		})
	}
}

$(document).ready(function(){
	$('.person_select_data').select2({ width: '100%',theme: "bootstrap4", placeholder: "Seleccione persona" })
	assignments_person_profiles = $("#assignments_person_profiles_table").DataTable({
		'columns': [
		 {'data': 'profile'},
		 {'data': 'start_date'},
		 {'data': 'end_date'}
		],
		'language': {'url': datatables_lang}
	})
	assignments_person_documents = $("#assignments_person_documents_table").DataTable({
		'columns': [
		 {'data': 'document'},
		 {'data': 'category'},
		 {'data': 'expire'},
		 {'data': 'expire_date'},
		 {'data': 'file'},
		 {'data': 'actions'}
		],
		'language': {'url': datatables_lang}
	})
})

