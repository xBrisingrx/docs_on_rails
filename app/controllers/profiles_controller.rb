class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]

  def index
    @profiles = Profile.actives
    @profile_type = ( params[:d_type] == 'people' ) ? 'personal' : 'vehiculos'
  end

  def show
  end

  def new
    @profile = Profile.new
    profile_type = ( params[:d_type] == 'people' ) ? 'personal' : 'vehiculos'
    @title_modal = "Registro de perfil para #{profile_type}"
  end

  def edit
  end

  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.json { render json: { status: :success, msg: 'Perfil agregado.' }, status: :created }
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully created." }
      else
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.json { render json: { status: :success, msg: 'Datos actualizados.'}, status: :ok, location: @profile }
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully updated." }
      else
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def disable
    @profile = Profile.find(params[:profile_id])
    if @profile.update(active:false)
      render json: { status: 'success', msg: 'Perfil eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:d_type, :name, :start_date, :description)
    end
end
