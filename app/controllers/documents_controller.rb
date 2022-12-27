class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]

  def index
    @documents = Document.where( d_type: params[:d_type]).actives
    @document_type = ( params[:d_type] == 'people' ) ? 'personal' : 'vehiculos'
  end

  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
    @expiration_types = ExpirationType.actives
    @categories = DocumentCategory.actives
    @title_modal = 'Registro de atributo'
  end

  def edit
    @expiration_types = ExpirationType.actives
    @categories = DocumentCategory.actives
    @title_modal = 'Registro de atributo'
  end

  def create
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
        format.json { render json: { status: 'success', msg: 'Atributo creado con éxito.' }, status: :created }
        format.html { redirect_to document_url(@document), notice: "Document was successfully created." }
      else
        format.json { render json: @document.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @document.update(document_params)
        format.json { render json: { status: 'success', msg: 'Atributo creado con éxito.' }, status: :ok }
        format.html { redirect_to document_url(@document), notice: "Document was successfully updated." }
      else
        format.json { render json: @document.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:name, :description, :expires, :days_of_validity, :d_type, 
        :allow_modify_expiration, :observations, :renewal_methodology, :start_date, :end_date, :active,
        :document_category_id, 
        :expiration_type_id)
    end
end
