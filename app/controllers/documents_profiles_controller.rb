class DocumentsProfilesController < ApplicationController
  before_action :set_documents_profile, only: %i[ show edit update destroy ]

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
      if @documents_profile.update(documents_profile_params)
        format.json {  render json: { status: :success, msg: 'Asignación actualidaza.' }, status: :ok, location: @documents_profile }
        format.html { redirect_to documents_profile_url(@documents_profile), notice: "Documents profile was successfully updated." }
      else
        format.json { render json: @documents_profile.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @documents_profile.destroy

    respond_to do |format|
      format.html { redirect_to documents_profiles_url, notice: "Documents profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_documents_profile
      @documents_profile = DocumentsProfile.find(params[:id])
    end

    def documents_profile_params
      params.require(:documents_profile).permit(:profile_id, :document_id, :start_date, :end_date, :d_type)
    end
end
