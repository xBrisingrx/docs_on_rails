class AssignmentsDocumentsController < ApplicationController

	def show
    if params[:assignated] == 'person'
      data = Person.find params[:id]
    else 
      data = ''
    end
    @documents = data.assignments_documents
  end

  private 
  def set_assignments_document
    @assignments_document = AssignmentsDocument.find(params[:id])
  end

  def assignments_document_params
    params.require(:assignments_document).permit(:name, :d_type, :description, 
      document_renovations: [ :renovation_date, :expiration_date, :comment, :assignments_document, :file[] ]
    )
  end
end
