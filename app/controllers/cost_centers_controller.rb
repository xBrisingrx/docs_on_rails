class CostCentersController < ApplicationController
  before_action :set_cost_center, only: %i[ show edit update destroy ]

  # GET /cost_centers or /cost_centers.json
  def index
    @title = 'Centros de costos'
    @cost_centers = CostCenter.actives.where(d_type: params[:d_type])
  end

  # GET /cost_centers/1 or /cost_centers/1.json
  def show
  end

  # GET /cost_centers/new
  def new
    @title_modal = 'Registrar centro de costos'
    @cost_center = CostCenter.new
    @d_type = params[:d_type]
  end

  # GET /cost_centers/1/edit
  def edit
  end

  # POST /cost_centers or /cost_centers.json
  def create
    @cost_center = CostCenter.new(cost_center_params)

    respond_to do |format|
      if @cost_center.save
        format.json { render json: {status: 'success', msg: 'Centro de costo registrado'}, status: :created}
        format.html { redirect_to cost_center_url(@cost_center), notice: "Cost center was successfully created." }
      else
        format.json { render json: @cost_center.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cost_centers/1 or /cost_centers/1.json
  def update
    respond_to do |format|
      if @cost_center.update(cost_center_params)
        format.json { render :show, status: :ok}
        format.html { redirect_to cost_center_url(@cost_center), notice: "Cost center was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cost_center.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    cost_center = CostCenter.find(params[:cost_center_id])
    activity_history = ActivityHistory.new( action: :disable, 
      description: "El usuario #{current_user.username} elimino el centro de costos #{cost_center.detail}", 
      record: cost_center, date: Time.now, user: current_user )
    if cost_center.update(active:false) && activity_history.save
      render json: { status: 'success', msg: 'Centro de costos eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cost_center
      @cost_center = CostCenter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cost_center_params
      params.require(:cost_center).permit(:profile_id, :zone_id, :job_id ,:active, :d_type, :descripcion)
    end
end
