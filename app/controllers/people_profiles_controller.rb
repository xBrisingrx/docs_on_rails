class PeopleProfilesController < ApplicationController
  before_action :set_people_profile, only: %i[ show edit update destroy ]

  def index
    @people_profiles = AssignmentsProfile.people
  end

  def show
  end

  def new
    @people_profile = AssignmentsProfile.new( assignated_type: :Person )
    @people = Person.actives.order(:last_name)
    @profiles = Profile.where( d_type: 1 ).actives.select(:id, :name)
    @title_modal = 'Asignar perfil a una persona'
  end

  def edit
    @documents = @people_profile.zone_job_profile.documents
  end

  def modal_disable
    @person_profile = AssignmentsProfile.find(params[:people_profile_id])
    @documents = @person_profile.zone_job_profile.documents
  end

  def by_person
    @people_profiles = AssignmentsProfile.where( assignated_id: params[:person_id] ).where( assignated_type: 'Person')
    respond_to do |format|
      format.json { render :index }
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
