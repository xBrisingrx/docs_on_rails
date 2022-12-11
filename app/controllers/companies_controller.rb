class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  def index
    @companies = Company.where( d_type: params[:d_type]).actives
    @company_type = ( params[:d_type] == 'people' ) ? 'personas ' : 'empresas'
  end

  def show
  end

  def new
    @company = Company.new
    @title_modal = 'Crear empresa'
  end

  def edit
    @title_modal = "Editar empresa: #{@company.name}"
  end

  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.json { render json: { status: :success, msg: 'Empresa agregada.' }, status: :created, location: @company }
      else
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_edit_params)
        format.json { render json: { status: :success, msg: 'Datos actualizados.'}, status: :ok, location: @company }
      else
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    @company = Company.find(params[:company_id])
    if @company.update(active:false)
      render json: { status: 'success', msg: 'Empresa eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :d_type, :description)
    end

    def company_edit_params
      params.require(:company).permit(:name, :description)
    end
end
