class VehiclesCostCentersController < ApplicationController
	before_action :set_vehicles_profile, only: %i[ show edit update destroy ]

  def index
    @vehicles_cost_centers = AssignmentsCostCenter.vehicles
  end

  def show
  end

  def new
    @vehicle_cost_center = AssignmentsCostCenter.new( assignated_type: :Vehicle )
    @vehicles = Vehicle.actives.order(:code)
    @cost_centers = CostCenter.actives.where(d_type: :vehicles)
    @title_modal = 'Asignar vehiculo'
    @statuses = AssignationStatus.where(d_type: :vehicles)
  end

  def edit
    @documents = @vehicles_profile.zone_job_profile.documents
  end

  def modal_disable
    @vehicle_profile = AssignmentsCostCenter.find(params[:vehicles_profile_id])
    @documents = @vehicle_profile.zone_job_profile.documents
  end

  private
    def set_vehicles_profile
      @vehicles_profile = AssignmentsCostCenter.find(params[:id])
    end

    def vehicles_profile_params
      params.permit(:assignated_id, :profile_id, :start_date, :end_date, :active)
    end
end
