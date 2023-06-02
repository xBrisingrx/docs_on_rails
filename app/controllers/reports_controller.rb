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
		@column_titles = ['INT', 'DOMINIO', 'ESTADO', 'EMPRESA', 'Centro de costos', 'Subcentro', 'CC DES', 'SUB-DES']
		@index_name = {'code'=> '' , 'domain'=> '', 'status' => '', 'company' => '', 'cost_center' => '', 'sub_center' => '', 'cc_des' => '' }
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
		vehicles_cost_centers.map { |cc|
			puts "\n\n un pase \n\n "
			row['code'] = cc.assignated.code
			row['domain'] = cc.assignated.domain 
			row['company'] = cc.assignated.company.name
			row['cost_center'] = cc.cost_center.center
			cc.cost_center.documents.actives.map { |document|
				renovation = cc.assignated.assignments_documents.find_by( assignated: cc.assignated, document_id: document.id ).last_renovation
				row["#{document.id}"] = ( renovation ) ? renovation.expiration_date : 'No cargado'
			}
			@data.push(row) 
			row = @index_name.clone
		}
	end

end
