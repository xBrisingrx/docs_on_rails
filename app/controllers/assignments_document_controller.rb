class AssignmentsDocumentController < ApplicationController
	def show
    if params[:assignated] == 'person'
      data = Person.find params[:id]
    else 
      data = ''
    end
    @documents = data.assignments_documents
  end
end
