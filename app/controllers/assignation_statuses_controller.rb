class AssignationStatusesController < ApplicationController
  before_action :set_assignation_status, only: %i[ show edit update destroy ]

  # GET /assignation_statuses or /assignation_statuses.json
  def index
    @title_modal = 'Estado registrados'
    @assignation_statuses = AssignationStatus.where( d_type: params[:d_type] )
    @d_type = params[:d_type]
  end

  # GET /assignation_statuses/1 or /assignation_statuses/1.json
  def show
  end

  # GET /assignation_statuses/new
  def new
    @title_modal = 'Registrar estado'
    @d_type = params[:d_type]
    @assignation_status = AssignationStatus.new( d_type: params[:d_type] )
  end

  # GET /assignation_statuses/1/edit
  def edit
    @title_modal = 'Actualizar estado'
  end

  # POST /assignation_statuses or /assignation_statuses.json
  def create
    @assignation_status = AssignationStatus.new(assignation_status_params)

    respond_to do |format|
      if @assignation_status.save
        format.json { render json: { status: 'success', msg: 'Estado registrado' }, status: :created }
      else
        format.json { render json: { status: 'error', msg: @assignation_status.errors }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignation_statuses/1 or /assignation_statuses/1.json
  def update
    respond_to do |format|
      if @assignation_status.update(assignation_status_params)
        format.json { render json: { status: 'success', msg: 'Estado actualizado' }, status: :ok }
      else
        format.json { rrender json: { status: 'error', msg: @assignation_status.errors }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignation_statuses/1 or /assignation_statuses/1.json
  def destroy
    @assignation_status.destroy

    respond_to do |format|
      format.html { redirect_to assignation_statuses_url, notice: "Assignation status was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignation_status
      @assignation_status = AssignationStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assignation_status_params
      params.require(:assignation_status).permit(:name, :description, :blocks, :d_type)
    end
end
