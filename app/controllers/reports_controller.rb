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
			 'company' => '', 'cost_center' => '', 'sub_center' => '', 'cc_des' => '', 'sub_des' => '',
			 'operators' => 'operators', 'clients'=> 'clients' }
		@data = Array.new
		@documents = Document.where(d_type: :vehicles).actives.pluck(:id, :name)
		@title = 'Matriz vehiculos final'
		@documents.map { |document|
			@index_name["#{document[0]}"] = ''
			@column_titles << document[1]
		} 

		row = @index_name.clone
		assignments = Assignment.where(assignated_type: 'Vehicle').order(:start_date)
		assignments.map { |assignment|
			row['code'] = assignment.assignated.code
			row['domain'] = assignment.assignated.domain 
			row['company'] = assignment.assignated.company.name
			row['cost_center'] = assignment.cost_center.number_center
			row['sub_center'] = assignment.cost_center.zone.code
			row['cc_des'] = assignment.cost_center.name_center
			row['sub_des'] = assignment.cost_center.zone.name
			row['status'] = assignment.assignation_status.name
			row['start_date'] = (assignment.start_date) ? assignment.start_date.strftime('%d-%m-%y') : '' 
			row['end_date'] = (assignment.end_date) ? assignment.end_date.strftime('%d-%m-%y') : '' 

			operators = ""
			clients = ""
			operators = assignment.operators.map { |operator| operators.insert(-1,"#{operator.name} / ") }
			clients = assignment.clients.map { |client| clients.concat("#{client.name} / ") }
			
			row['operators'] = operators[0].chop.chop
			row['clients'] = clients[0].chop.chop
			assignment.cost_center.documents.actives.map { |document|
				renovation = assignment.assignated.assignments_documents.find_by( assignated: assignment.assignated, document_id: document.id ).last_renovation
				if !renovation.blank?
					row["#{document.id}"] = ( document.expires? ) ? renovation.expiration_date.strftime('%d-%m-%y') : 'Cargado'
				else
					row["#{document.id}"] = 'No cargado'
				end
			}
			
			@data.push(row) 
			row = @index_name.clone
		}
	end

	def matriz_vehicles_mail
		@column_titles = ['INT', 'DOMINIO', 'ESTADO', 'DESDE', 'HASTA', 'EMPRESA', 'Centro de costos', 
											'Subcentro', 'CC DES', 'SUB-DES', 'OPERADORA', 'CLIENTE']
		@index_name = {'code'=> '' , 'domain'=> '', 'status' => '', 'start_date'=> '', 'end_date'=> '',
			 'company' => '', 'cost_center' => '', 'sub_center' => '', 'cc_des' => '', 'sub_des' => '',
			 'operators' => 'operators', 'clients'=> 'clients' }
		@data = Array.new
		@documents = Document.where(d_type: :vehicles).actives.pluck(:id, :name)
		@title = 'Matriz vehiculos final'
		@documents.map { |document|
			@index_name["#{document[0]}"] = ''
			@column_titles << document[1]
		} 

		row = @index_name.clone
		assignments = Assignment.where(assignated_type: 'Vehicle').order(:start_date)
		assignments.map { |assignment|
			row['code'] = assignment.assignated.code
			row['domain'] = assignment.assignated.domain 
			row['company'] = assignment.assignated.company.name
			row['cost_center'] = assignment.cost_center.number_center
			row['sub_center'] = assignment.cost_center.zone.code
			row['cc_des'] = assignment.cost_center.name_center
			row['sub_des'] = assignment.cost_center.zone.name
			row['status'] = assignment.assignation_status.name
			row['start_date'] = (assignment.start_date) ? assignment.start_date.strftime('%d-%m-%y') : '' 
			row['end_date'] = (assignment.end_date) ? assignment.end_date.strftime('%d-%m-%y') : '' 

			operators = ""
			clients = ""
			operators = assignment.operators.map { |operator| operators.insert(-1,"#{operator.name} / ") }
			clients = assignment.clients.map { |client| clients.concat("#{client.name} / ") }
			
			row['operators'] = operators[0].chop.chop
			row['clients'] = clients[0].chop.chop
			assignment.cost_center.documents.actives.map { |document|
				renovation = assignment.assignated.assignments_documents.find_by( assignated: assignment.assignated, document_id: document.id ).last_renovation
				if !renovation.blank?
					row["#{document.id}"] = ( document.expires? ) ? renovation.expiration_date.strftime('%d-%m-%y') : 'Cargado'
				else
					row["#{document.id}"] = 'No cargado'
				end
			}
			
			@data.push(row) 
			row = @index_name.clone
		}
		p = Axlsx::Package.new
		p.workbook do |wb|
			wb.add_worksheet(name: "Unificador") do |sheet|
				sheet.add_row @column_titles
			  @data.each_with_index do |d, index|
			  	if index.odd?
			  		sheet.add_row d.values
			  	else
			  		sheet.add_row d.values
			  	end
			  end
			end
		end
		p.serialize("example.xlsx")

		# Serialize to a stream
		s = p.to_stream()
		File.open(Rails.root.join("app/assets/reports/reporte_vehiculos.xlsx"), mode: 'w', encoding: 'ASCII-8BIT') { |f| f.write(s.read) }
		data = render_to_string handlers: [:axlsx], formats: [:xlsx], template: 'reports/matriz_vehicles.xlsx.axlsx'
		#File.write(Rails.root.join("app/assets/reports/prueba.xlsx"),"w")
		# File.open(Rails.root.join("app/assets/reports/prueba2.xlsx"),"w") {|f| f.write(data) }
		send_data data, filename: "prueba.xlsx", type: Mime[:xlsx], disposition: 'inline'
		export_file_path = [Rails.root, "public", "uploads", "exports", "excel.xlsx"].join("/")
		# s.write export_file_path
		# p.write export_file_path
		# send_file export_file_path, :content_type => "application/vnd.ms-excel", :disposition => 'inline'
		NotifyMailer.vehicles_report().deliver_later
	end

end
