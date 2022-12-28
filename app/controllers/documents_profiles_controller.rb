class DocumentsProfilesController < ApplicationController
  before_action :set_documents_profile, only: %i[ show edit update modal_disable ]

  def index
    @documents_profiles = DocumentsProfile.where(d_type: params[:d_type])
  end

  def show
  end

  def new
    @documents_profile = DocumentsProfile.new
    @title_modal = 'Agregar documento a un perfil'
    @profiles = Profile.where( d_type: params[:d_type])
    @documents = Document.where( d_type: params[:d_type])
  end

  def edit
    @title_modal = 'Editar'
    @profiles = Profile.where( d_type: @documents_profile.d_type)
    @documents = Document.where( d_type: @documents_profile.d_type)
  end

  def create
    @documents_profile = DocumentsProfile.new(documents_profile_params)

    respond_to do |format|
      if @documents_profile.save
        format.json { render json: { status: :success, msg: 'Documento asignado al perfil.' } , status: :created }
        format.html { redirect_to documents_profile_url(@documents_profile), notice: "Documents profile was successfully created." }
      else
        format.json { render json: @documents_profile.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @documents_profile.update(document_profile_update_params)
        format.json {  render json: { status: :success, msg: 'Datos actualizados.' }, status: :ok, location: @documents_profile }
        format.html { redirect_to documents_profile_url(@documents_profile), notice: "Documents profile was successfully updated." }
      else
        format.json { render json: @documents_profile.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def modal_disable;end

  def disable
    @document_profile = DocumentsProfile.find(params[:document_profile_id])

    respond_to do |format|
      if @document_profile.update(active: false, end_date: params[:end_date])
        format.json { render json: { msg: 'Operacion exitosa', status: 'success' }, status: :ok }
      else
        format.json { render json: { msg: 'Ocurrio un error al realizar la operacion' }, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_documents_profile
      @documents_profile = DocumentsProfile.find(params[:id])
    end

    def documents_profile_params
      params.require(:documents_profile).permit(:profile_id, :document_id, :start_date, :end_date, :d_type)
    end

    def document_profile_update_params
      params.require(:documents_profile).permit(:start_date)
    end
end
