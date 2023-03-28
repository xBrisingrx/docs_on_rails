class VehicleInsurancesController < ApplicationController
	before_action :set_insurance, only: %i[ edit update destroy ]

  def index
    @vehicle = Vehicle.find params[:vehicle_id]
    @vehicle_insurances = @vehicle.vehicle_insurances
    # @document_renovations = @assigned_document.document_renovations.actives.order(expiration_date: :DESC) 
    @vehicle_insurance = VehicleInsurance.new
    @title_modal = "Seguros del vehiculo #{@vehicle.code}"
  end

  def show
  	vehicle = Vehicle.find params[:id]
  	vehicle_insurances = vehicle.vehicle_insurances
  end

  def new
    @insurance = Insurance.new
    @title_modal = 'Crear empresa'
  end

  def edit
    @title_modal = "Editar empresa: #{@insurance.name}"
  end

  def create
    @insurance = Insurance.new(insurance_params)
    activity_history = ActivityHistory.new( action: :create_record, description: "El usuario #{current_user.username} registro la empresa #{@insurance.name}", 
      record: @insurance, date: Time.now, user: current_user )
    respond_to do |format|
      if @insurance.save && activity_history.save
        format.json { render json: { status: :success, msg: 'Empresa agregada.' }, status: :created, location: @insurance }
      else
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    activity_history = ActivityHistory.new( action: :update_record, description: "El usuario #{current_user.username} actualizo datos de la empresa #{@insurance.name}", 
      record: @insurance, date: Time.now, user: current_user )
    respond_to do |format|
      if @insurance.update(insurance_edit_params) && activity_history.save
        format.json { render json: { status: :success, msg: 'Datos actualizados.'}, status: :ok, location: @insurance }
      else
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    insurance = Insurance.find(params[:insurance_id])
    activity_history = ActivityHistory.new( action: :disable, description: "El usuario #{current_user.username} elimino la empresa #{insurance.name}", 
      record: insurance, date: Time.now, user: current_user )
    if insurance.update(active:false) && activity_history.save
      render json: { status: 'success', msg: 'Empresa eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    def set_insurance
      @insurance = Insurance.find(params[:id])
    end

    def insurance_params
      params.require(:insurance).permit(:vehicle_id, :insurance_id, :policy, :start_date, :end_date)
    end

    def insurance_edit_params
      params.require(:insurance).permit(:name, :description)
    end
end
