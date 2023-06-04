class ReportsController < ApplicationController

	def index;end

	def people
		@people = Person.actives
		respond_to do |format|
			format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="all_people.xlsx"'
      }
		end
	end

	def matriz
		@column_titles = ['LEGAJO', 'APELLIDO/S, NOMBRE/S (DNI)']
		@index_name = ['file', 'fullname']
		@documents = Document.where(d_type: 1).actives.pluck(:id, :name)
		@title = 'Excel title'
		@documents.map { |document|
			@index_name << document[0]
			@column_titles << document[1]
		}

		respond_to do |format|
			format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="informe_matriz_personas.xlsx"'
      }
		end
	end

	def matriz_vehicles
		@column_titles = ['INT', 'DOMINIO', 'ESTADO', 'DESDE', 'HASTA', 'EMPRESA', 'Centro de costos', 
											'Subcentro', 'CC DES', 'SUB-DES', 'OPERADORA', 'CLIENTE']
		@index_name = {'code'=> '' , 'domain'=> '', 'status' => '', 'start_date'=> '', 'end_date'=> '',
			 'company' => '', 'cost_center' => '', 'sub_center' => '', 'cc_des' => '', 
			 'operators' => 'operators', 'clients'=> 'clients' }
		@data = Array.new
		@vehicles = Vehicle.actives
		vehicles_cost_centers = AssignmentsCostCenter.where(assignated_type: 'Vehicle')
		@documents = Document.where(d_type: :vehicles).actives.pluck(:id, :name)
		@title = 'Matriz vehiculos final'
		@documents.map { |document|
			@index_name["#{document[0]}"] = 'No cargado'
			@column_titles << document[1]
		} 

		row = @index_name.clone
		vehicles_states = VehicleState.all
		vehicles_states.map { |vehicle|
			puts "\n\n un pase \n\n "
			row['code'] = vehicle.vehicle.code
			row['domain'] = vehicle.vehicle.domain 
			row['company'] = vehicle.vehicle.company.name
			row['cost_center'] = vehicle.cost_center.center
			row['sub_center'] = vehicle.cost_center.subcenter
			row['status'] = vehicle.assignation_status.name
			row['start_date'] = (vehicle.start_date) ? vehicle.start_date.strftime('%d-%m-%y') : '' 
			row['end_date'] = (vehicle.end_date) ? vehicle.end_date.strftime('%d-%m-%y') : '' 

			operators = ""
			clients = ""
			operators = vehicle.operators.map { |operator| operators.insert(-1,"#{operator.name} / ") }
			clients = vehicle.clients.map { |client| clients.concat("#{client.name} / ") }
			
			row['operators'] = operators[0].chop.chop
			row['clients'] = clients[0].chop.chop
			vehicle.cost_center.documents.actives.map { |document|
				renovation = vehicle.vehicle.assignments_documents.find_by( assignated: vehicle.vehicle, document_id: document.id ).last_renovation
				row["#{document.id}"] = ( renovation ) ? renovation.expiration_date : 'No cargado'
			}
			
			@data.push(row) 
			row = @index_name.clone
		}
		# vehicles_cost_centers.map { |cc|
		# 	puts "\n\n un pase \n\n "
		# 	row['code'] = cc.assignated.code
		# 	row['domain'] = cc.assignated.domain 
		# 	row['company'] = cc.assignated.company.name
		# 	row['cost_center'] = cc.cost_center.center
		# 	row['status'] = cc.cost_center.center
		# 	cc.cost_center.documents.actives.map { |document|
		# 		renovation = cc.assignated.assignments_documents.find_by( assignated: cc.assignated, document_id: document.id ).last_renovation
		# 		row["#{document.id}"] = ( renovation ) ? renovation.expiration_date : 'No cargado'
		# 	}
		# 	@data.push(row) 
		# 	row = @index_name.clone
		# }
	end

end
