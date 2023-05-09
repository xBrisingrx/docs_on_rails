class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]

  def index
    @jobs = Job.where(d_type: params[:d_type]).actives
    @type = (params[:d_type] == 'people') ? 'personas' : 'vehículos'
    @title_modal = 'Puestos laborales'
  end

  def show;end

  def new
    @title_modal = 'Registrar puesto de trabajo'
    @job = Job.new
    @type = params[:d_type]
  end

  def edit
    @title_modal = "Editar puesto #{@job.name}"
    @type = @job.d_type
  end

  def create
    job = Job.new(job_params)
    activity_history = ActivityHistory.new( action: :create_record, description: "El usuario #{current_user.username} registro el puesto laboral #{job.name}", 
      record: job, date: Time.now, user: current_user )
    if job.save && activity_history && activity_history.save
      render json: { status: :success, msg: 'Puesto laboral agregado.' }, status: :created
    else
      render json: { status: :error, msg: 'No se pudo registrar el puesto laboral.' }, status: :unprocessable_entity
    end
  end

  def update
    activity_history = ActivityHistory.new( action: :update_record, description: "El usuario #{current_user.username} actualizo los datos del puesto laboral #{@job.name}", 
      record: @job, date: Time.now, user: current_user )
    respond_to do |format|
      if @job.update(job_params) && activity_history.save
        format.json { render json: { status: :success, msg: 'Datos actualizados.' }, status: :ok }
      else
        format.json { render json: { status: :error, msg: @job.errors }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def disable
    job = Job.find(params[:job_id])
    activity_history = ActivityHistory.new( action: :disable, description: "El usuario #{current_user.username} dio de baja el puesto laboral #{job.name}", 
      record: job, date: Time.now, user: current_user )
    if job.disable && activity_history.save
      render json: { status: :success, msg: 'Puesto laboral dado de baja.' }, status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:d_type, :name, :code ,:description)
    end
end
