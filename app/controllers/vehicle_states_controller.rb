class VehicleStatesController < ApplicationController
  before_action :set_vehicle_state, only: %i[ show edit update destroy ]

  # GET /vehicle_states or /vehicle_states.json
  def index
    @vehicle_states = VehicleState.all
  end

  # GET /vehicle_states/1 or /vehicle_states/1.json
  def show
  end

  # GET /vehicle_states/new
  def new
    @vehicle_state = VehicleState.new
    @title_modal = 'Asignar vehiculo'
    @cost_centers = CostCenter.actives.where(d_type: :vehicles)
  end

  # GET /vehicle_states/1/edit
  def edit
  end

  # POST /vehicle_states or /vehicle_states.json
  def create
    @vehicle_state = VehicleState.new(vehicle_state_params)

    respond_to do |format|
      if @vehicle_state.save
        format.json { render json: { status: 'success', msg: 'Exito'}, status: :created }
        format.html { redirect_to vehicle_state_url(@vehicle_state), notice: "Vehicle state was successfully created." }
      else
        format.json { render json: @vehicle_state.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_states/1 or /vehicle_states/1.json
  def update
    respond_to do |format|
      if @vehicle_state.update(vehicle_state_params)
        format.html { redirect_to vehicle_state_url(@vehicle_state), notice: "Vehicle state was successfully updated." }
        format.json { render :show, status: :ok, location: @vehicle_state }
      else
        format.json { render json: @vehicle_state.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_states/1 or /vehicle_states/1.json
  def destroy
    @vehicle_state.destroy

    respond_to do |format|
      format.html { redirect_to vehicle_states_url, notice: "Vehicle state was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_state
      @vehicle_state = VehicleState.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_state_params
      params.require(:vehicle_state).permit(:vehicle_id, :cost_center_id, :sub_zone_id, 
        :list_states_vehicle_id, :operator_id, :client_id, :start_date, :end_date)
    end
end
