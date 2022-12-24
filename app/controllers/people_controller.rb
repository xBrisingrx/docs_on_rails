class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update upload_person_file ]

  def index
    @people = Person.actives
  end

  def show;end

  def new
    @person = Person.new
    @title_modal = 'Alta de persona'
  end

  def edit
    @title_modal = "Actualizar datos de: #{@person.fullname}"
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.json { render json: { status: :success, msg: 'Persona registrada con éxito.'}, status: :created }
        format.html { redirect_to person_url(@person), notice: "Person was successfully created." }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.json { render json: { status: :success, msg: 'Datos actualizados.'}, status: :ok }
        format.html { redirect_to people_path, notice: "Person was successfully updated." }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def disable
    @person = Person.find(params[:person_id])
    if @person.update(active:false)
      render json: { status: 'success', msg: 'Persona eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  def upload_person_file
    @title_modal = "Cargar archivo de #{params[:file_name]} a #{ @person.fullname }"
    @file = params[:file]
  end

  def dato_disponible # Verificamos que el dato no este en uso
    person = Person.where("#{params['attribute']}" => params['value']).first

    if person.nil?
      render json: 'true'
    else
      if !params['person_id'].blank?
        if params['person_id'].to_i == person.id
          render json: 'true'
        else
          render json: 'false'
        end
      else
        render json: 'false'
      end
    end
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:file, :name, :last_name, :dni, :dni_has_expiration, 
        :date_expiration_dni, :birth_date, :nationality, :direction, :phone, :date_start_activity, 
        :dni_file, :cuil_file, :start_activity_file, :tramit_number, :cuil, :start_activity, :email)
    end
end
