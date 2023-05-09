class AssignmentsCostCentersController < ApplicationController
  before_action :set_assignments_cost_center, only: %i[ edit update destroy ]

  # GET /assignments_cost_centers or /assignments_cost_centers.json
  def index
    @assignments_cost_centers = AssignmentsCostCenter.all
  end

  def show
    if params[:assignated] == 'person'
      data = Person.find params[:id]
    else 
      data = Vehicle.find params[:id]
    end
    @assignment_cost_centers = data.assignments_cost_centers
  end

  # GET /assignments_cost_centers/new
  def new
    @assignments_cost_center = AssignmentsCostCenter.new
  end

  # GET /assignments_cost_centers/1/edit
  def edit
  end

  # POST /assignments_cost_centers or /assignments_cost_centers.json
  def create
    @assignments_cost_center = AssignmentsCostCenter.new(assignments_cost_center_params)

    respond_to do |format|
      if @assignments_cost_center.save
        format.json { render json: { status: :success, msg: 'Asignacion exitosa.' }, status: :created }
      else
        format.json { render json: { status: :error, msg: @assignments_cost_center.errors }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments_cost_centers/1 or /assignments_cost_centers/1.json
  def update
    respond_to do |format|
      if @assignments_cost_center.update(assignments_cost_center_params)
        format.json { render :show, status: :ok }
        format.html { redirect_to assignments_cost_center_url(@assignments_cost_center), notice: "Assigments cost center was successfully updated." }
      else
        format.json { render json: @assignments_cost_center.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments_cost_centers/1 or /assignments_cost_centers/1.json
  def destroy
    @assignments_cost_center.destroy

    respond_to do |format|
      format.html { redirect_to assignments_cost_centers_url, notice: "Assigments cost center was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_disponibility
    assignment = AssignmentsCostCenter.where( assignated_id: params[:assignated_id]) 
      .where(assignated_type: params[:assignated_type])
      .where('start_date >= ?', params[:start_date])
      .or(AssignmentsCostCenter.where('end_date <= ?', params[:end_date]))
    if assignment.empty?
      render json: { status: 'free',msg: '' }
    else
      if assignment.first.assignated_type == 'Person'
        msg = "La persona seleccionada ya se encuentra asignada en esas fechas"
      else
        msg = "La unidad seleccionada ya se encuentra asignada en esas fechas"
      end
      render json: { status: 'busy',msg: msg }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignments_cost_center
      @assignments_cost_center = AssignmentsCostCenter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assignments_cost_center_params
      params.require(:assignments_cost_center).permit(:cost_center_id, :assignated_id, :assignated_type, :operator_id, 
        :client_id, :active, :start_date, :end_date, :assignation_status_id)
    end
end
