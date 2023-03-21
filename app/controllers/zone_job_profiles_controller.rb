class ZoneJobProfilesController < ApplicationController
  before_action :set_zone_job_profile, only: %i[ show edit update destroy ]

  def index
    @zone_job_profiles = ZoneJobProfile.where( d_type: params[:d_type])
  end

  def show
  end

  def new
    @job = Job.find params[:job_id]
    @zone_job_profile = ZoneJobProfile.new()
    @zones = Zone.actives
    @profiles = Profile.where( d_type: params[:d_type])
    @title_modal = "Asignar convenio a #{@job.name}"
  end

  def edit
    @title_modal = "Desvincular puesto #{@zone_job_profile.name}"
  end

  def create
    errors = []
    ActiveRecord::Base.transaction do
      for i in 1..params[:count].to_i do 
        entry = ZoneJobProfile.new(
          job_id: params[:job_id],
          d_type: params[:d_type],
          zone_id: params["zone_#{i}".to_sym].to_i,
          profile_id: params["profile_#{i}".to_sym].to_i
        )
        if entry.save
          ActivityHistory.create( action: :create_record, 
            description: "Se registro #{entry.name}", record: @profile, date: Time.now, user: current_user )
        else
          entry.errors.messages.map { |k,v| errors << v }
        end
      end
    end

    if errors.empty?
      render json: { status: :success, msg: 'Asociación exitosa' }, status: :ok
    else
      byebug
      render json: { status: :error, msg: errors }, status: :unprocessable_entity
    end
    
    # rescue ActiveRecord::RecordInvalid => invalid
    #   pp invalid.record.errors
    #   status = ( invalid.record.errors["uniqueness"].empty? ) ? 'error' : 'info'
    #   msg = ( invalid.record.errors["uniqueness"].empty? ) ? 'error' : 'info'
    #   # byebug
    #   invalid.record.errors.map { |k,v| errors << v }
    #   render json: { status: status, msg: errors }, status: :unprocessable_entity
  end

  def update
    respond_to do |format|
      if @zone_job_profile.disable(Time.now)
        format.json { render json: { status: :success, msg: 'Desvinculación exitosa' }, status: :ok }
      else
        format.json { render json: @zone_job_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @zone_job_profile.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_zone_job_profile
      @zone_job_profile = ZoneJobProfile.find(params[:id])
    end

    def zone_job_profile_params
      params.require(:zone_job_profile).permit(:zone_id, :job_id, :profile_id,:d_type)
    end
end