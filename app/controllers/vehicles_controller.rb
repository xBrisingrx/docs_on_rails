class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy ]
  before_action :set_vehicle_data, only: %i[ new edit ]

  # GET /vehicles or /vehicles.json
  def index
    @vehicles = Vehicle.all
  end

  # GET /vehicles/1 or /vehicles/1.json
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles or /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.json { render :show, status: :created, location: @vehicle }
        format.html { redirect_to vehicle_url(@vehicle), notice: "Vehicle was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1 or /vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.json { render :show, status: :ok, location: @vehicle }
        format.html { redirect_to vehicle_url(@vehicle), notice: "Vehicle was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1 or /vehicles/1.json
  def destroy
    @vehicle.destroy

    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: "Vehicle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def set_vehicle_data
      @types = VehicleType.actives 
      @brands = VehicleBrand.actives 
      @models = VehicleModel.actives.includes(:vehicle_brand)
      @locations = VehicleLocation.actives 
      @companies = Company.where( d_type: :vehicles)
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:vehicle).permit(:code, :domain, :chassis, :engine, :seats, :year, :vehicle_type_id, :vehicle_model_id, :vehicle_location_id, :active)
    end
end
