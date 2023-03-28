class AssignmentsDocumentsController < ApplicationController
  before_action :set_assignments_document, only: %i[ modal_disable ]
  def new
    @assignments_document = AssignmentsDocument.new(assignated_type: params[:assignated_type])
    d_type = ( params[:assignated_type] == 'Person' ) ? 'people' : 'vehicles'
    @documents = Document.actives.where(d_type: d_type)
  end

  def create
    @assignments_document = AssignmentsDocument.new(assignments_document_params)
    respond_to do |format|
      if @assignments_document.assign
        if @assignments_document.errors.count > 0
          format.json { render json: { status: :info, msg: @assignments_document.errors.first[1] }, status: :ok }
        else
          format.json { render json: { status: :success, msg: 'Documento asignado.' }, status: :created }
        end
      else
        format.json { render json: @assignments_document.errors, status: :unprocessable_entity }
      end
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

	def show
    @array = Array.new
    if params[:assignated] == 'person'
      data = Person.find params[:id]
    else 
      data = Vehicle.find params[:id]
      @array << {
        document: 'Imágenes',
        category: '',
        expire: '',
        expire_date: '',
        last_renovation: '',
        has_renovations: false,
        actions: "<button class='btn u-btn-indigo btn-xs' title='Listar seguros' onclick='modal_seguros_vehiculos(#{data.assignated.id})' ><i class='fa fa-shield'></i></button>",
        custom: true
      }
    end
    @documents = data.assignments_documents.actives
    
    @documents.to_a.map { |d| 
      @array << {
        id: d.id,
        document: d.document.name,
        category: d.document.document_category.name,
        expire: d.document.expires? ? 'Si' : 'No',
        expire_date: (d.last_renovation) ? date_format(document.last_renovation.expiration_date) : '',
        last_renovation: d.last_renovation.nil?,
        has_renovations: d.has_renovations?,
        custom: false
      }
    }

  end

  def modal_disable;end

  def disable
    @assignments_document = AssignmentsDocument.find(params[:id])
    if @assignments_document.update(active: false, custom: true)
      render json: { status: :success, msg: 'Documento desvinculado.' }, status: :ok
    else
      render json: { status: :error, msg: 'Error al devincular documento.' }, status: :unprocessable_entity
    end
  end

  private 
  def set_assignments_document
    @assignments_document = AssignmentsDocument.find(params[:id])
  end

  def assignments_document_params
    params.require(:assignments_document).permit(:assignated_type, :assignated_id, :document_id, :custom, 
      :start_date, :end_date)
  end
end
