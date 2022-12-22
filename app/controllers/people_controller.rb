class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update upload_person_file ]

  def index
    @people = Person.actives
  end

  def show
  end

  def new
    @title_modal = 'Alta de persona'
    @person = Person.new
  end

  def edit
    @title_modal = "Actualizar datos de: #{@person.fullname}"
  end

  def create
    @person = Person.new(person_params)
    @person.set_company
    respond_to do |format|
      if @person.save
        format.html { redirect_to people_path, notice: "Persona registrada con éxito." }
        format.json { render json: { status: :success, msg: 'Persona registrada con éxito.'}, status: :created }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to person_url(@person), notice: "Person was successfully updated." }
        format.json { render json: { status: :success, msg: 'Datos actualizados.'}, status: :ok }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
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

  def dato_disponible
    # Verificamos que el dato no este en uso
    person = Person.where("#{params['attribute']}" => params['value']).first

    if person.nil?
      pp 'no se encontro ninguna persona con este legajo'
      render json: 'true'
    else
      if !params['person_id'].blank?
        puts 'Estamos editando'
        # Estamos editando
        if params['person_id'].to_i == person.id
          # El id encontrado es el de la persona que estamos editando
          pp 'El id encontrado es el de la persona que estamos editando'
          render json: 'true'
        else
          puts " desiguales:  #{params['person_id'] == person.id}"
          # El ID encontrado no es el de la persona que editamos
          pp 'El ID encontrado no es el de la persona que editamos'
          render json: 'false'
        end
      else
        # Estamos creando una persona y el legajo pertenece a alguien mas
        pp 'Estamos creando una persona y el legajo pertenece a alguien mas'
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
