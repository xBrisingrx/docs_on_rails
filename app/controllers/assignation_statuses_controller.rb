class AssignationStatusesController < ApplicationController
  # Lista de estados que se pueden poner cuando se asigna una unidad/persona a algun centro de costos
  before_action :set_assignation_status, only: %i[ show edit update destroy ]

  def index
    @title_modal = 'Estado registrados'
    @assignation_statuses = AssignationStatus.where( d_type: params[:d_type] )
    @d_type = params[:d_type]
  end

  def show
  end

  def new
    @title_modal = 'Registrar estado'
    @d_type = params[:d_type]
    @assignation_status = AssignationStatus.new( d_type: params[:d_type] )
  end

  def edit
    @title_modal = 'Actualizar estado'
  end

  def create
    @assignation_status = AssignationStatus.new(assignation_status_params)

    respond_to do |format|
      if @assignation_status.save
        format.json { render json: { status: 'success', msg: 'Estado registrado' }, status: :created }
      else
        format.json { render json: { status: 'error', msg: @assignation_status.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @assignation_status.update(assignation_status_params)
        format.json { render json: { status: 'success', msg: 'Estado actualizado' }, status: :ok }
      else
        format.json { rrender json: { status: 'error', msg: @assignation_status.errors }, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_assignation_status
      @assignation_status = AssignationStatus.find(params[:id])
    end

    def assignation_status_params
      params.require(:assignation_status).permit(:name, :description, :blocks, :d_type)
    end
end
