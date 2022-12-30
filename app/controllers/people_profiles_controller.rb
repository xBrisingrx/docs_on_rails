class PeopleProfilesController < ApplicationController
  before_action :set_people_profile, only: %i[ show edit update destroy ]

  def index
    @people_profiles = AssignmentsProfile.where( assignated_type: :person ).actives
  end

  def show
  end

  def new
    @people_profile = AssignmentsProfile.new
    @people = Person.actives 
    @profiles = Profile.where(d_type: :people, active: true)
    @title_modal = 'Asignar perfil a una persona'
  end

  def edit
  end

  def create
    @people_profile = AssignmentsProfile.new(
      assignated_type: :Person,
      assignated_id: params[:person_id],
      start_date: params[:start_date],
      profile_id: params[:profile_id]
    )
    respond_to do |format|
      if @people_profile.save
        format.json { render json: { status: :success, msg: 'Perfil asignado.' }, status: :created }
        format.html { redirect_to people_profile_url(@people_profile), notice: "People profile was successfully created." }
      else
        format.json { render json: @people_profile.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @people_profile.update(people_profile_params)
        format.json { render json: { status: :success, msg: 'Asignación actualizada.' }, status: :ok }
        format.html { redirect_to people_profile_url(@people_profile), notice: "People profile was successfully updated." }
      else
        format.json { render json: @people_profile.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @people_profile.destroy

    respond_to do |format|
      format.html { redirect_to people_profiles_url, notice: "People profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_people_profile
      @people_profile = AssignmentsProfile.find(params[:id])
    end

    def people_profile_params
      params.permit(:assignated_id, :profile_id, :start_date, :end_date, :active)
    end
end
