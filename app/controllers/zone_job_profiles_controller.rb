class ZoneJobProfilesController < ApplicationController
  before_action :set_zone_job_profile, only: %i[ show edit update destroy ]

  # GET /jobs or /jobs.json
  def index
    @zone_job_profiles = ZoneJobProfile.where( d_type: params[:d_type])
  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.find params[:job_id]
    @zone_job_profile = ZoneJobProfile.new()
    @zones = Zone.actives
    @profiles = Profile.where( d_type: params[:d_type])
    @title_modal = "Asignar convenio a #{@job.name}"
  end

  # GET /jobs/1/edit
  def edit
    @title_modal = "Editar puesto #{@zone_job_profile.name}"
  end

  # POST /jobs or /jobs.json
  def create
    ActiveRecord::Base.transaction do
      for i in 1..params[:count].to_i do 
        ZoneJobProfile.create(
          job_id: params[:job_id],
          d_type: params[:d_type],
          zone_id: params["zone_#{i}".to_sym].to_i,
          profile_id: params["profile_#{i}".to_sym].to_i
        )
      end
      render json: { status: :success, msg: 'Asociacion exitosa' }, status: :ok
    end
    rescue ActiveRecord::RecordInvalid
      render json: { status: :error, msg: 'Error al asociar el perfil' }, status: :unprocessable_entity
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @zone_job_profile.update(job_params)
        format.html { redirect_to job_url(@zone_job_profile), notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @zone_job_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @zone_job_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @zone_job_profile.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zone_job_profile
      @zone_job_profile = ZoneJobProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def zone_job_profile_params
      params.require(:zone_job_profile).permit(:zone_id, :job_id, :profile_id,:d_type)
    end
end