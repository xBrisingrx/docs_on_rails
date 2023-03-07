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
end
