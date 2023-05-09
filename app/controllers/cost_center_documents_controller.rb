class CostCenterDocumentsController < ApplicationController
  before_action :set_cost_center_document, only: %i[ show edit update destroy modal_disable modal_reactive ]

  def index
    @cost_center_documents = CostCenterDocument.includes(:cost_center).where('cost_center_documents.d_type = ?', params[:d_type])
  end

  # GET /cost_center_documents/1 or /cost_center_documents/1.json
  def show
  end

  # GET /cost_center_documents/new
  def new
    @cost_center_document = CostCenterDocument.new
    @title_modal = 'Agregar documentos a un centro de costos'
    @cost_center = CostCenter.cost_center_order( params[:d_type] )
    @documents = Document.where( d_type: params[:d_type]).actives.select(:id, :name).order(name: 'ASC')
  end

  # GET /cost_center_documents/1/edit
  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      for i in 1..params[:count].to_i do 
        entry = CostCenterDocument.new(
          cost_center_id: params[:cost_center_id],
          d_type: params[:d_type],
          document_id: params["document_#{i}".to_sym].to_i,
          start_date: params["start_date_#{i}".to_sym]
        )
        entry.assignment_document
      end
      entry.update_asociations
      render json: { status: :success, msg: 'Asociacion exitosa' }, status: :ok
    end
    rescue StandardError => e
      render json: { status: :info, msg: e.message }, status: :ok
    rescue ActiveRecord::RecordInvalid
      render json: { status: :error, msg: 'No se pudieron asociar los documentos' }, status: :unprocessable_entity
  end

  # PATCH/PUT /cost_center_documents/1 or /cost_center_documents/1.json
  def update
    respond_to do |format|
      if @cost_center_document.update(cost_center_document_params)
        format.html { redirect_to cost_center_document_url(@cost_center_document), notice: "Cost center document was successfully updated." }
        format.json { render :show, status: :ok, location: @cost_center_document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cost_center_document.errors, status: :unprocessable_entity }
      end
    end
  end

  def modal_disable;end

  def disable
   @cost_center_document = CostCenterDocument.find(params[:id])
    respond_to do |format|
      if @cost_center_document.disable(params[:end_date])
        format.json { render json: { msg: 'Operacion exitosa', status: 'success' }, status: :ok }
      else
        format.json { render json: { msg: 'Ocurrio un error al realizar la operacion' }, status: :unprocessable_entity }
      end
    end
  end

  def modal_reactive;end

  def reactive
    @cost_center_document = CostCenterDocument.find(params[:id])
    respond_to do |format|
      if @cost_center_document.reactive(params[:start_date])
        format.json { render json: { msg: 'Operacion exitosa', status: 'success' }, status: :ok }
      else
        format.json { render json: { msg: 'Ocurrio un error al realizar la operacion' }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cost_center_documents/1 or /cost_center_documents/1.json
  def destroy
    @cost_center_document.destroy

    respond_to do |format|
      format.html { redirect_to cost_center_documents_url, notice: "Cost center document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cost_center_document
      @cost_center_document = CostCenterDocument.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cost_center_document_params
      params.require(:cost_center_document).permit(:cost_center_id, :document_id, :active, :d_type)
    end
end
