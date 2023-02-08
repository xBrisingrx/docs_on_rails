class ZoneJobProfileDocsController < ApplicationController
  def index
    @entries = ZoneJobProfileDoc.where( d_type: params[:d_type])
  end

  def new
    @zone_job_profile_doc = ZoneJobProfileDoc.new
    @title_modal = 'Agregar documento a un perfil'
    @profiles = ZoneJobProfile.where( d_type: params[:d_type]).actives
    @documents = Document.where( d_type: params[:d_type]).actives.select(:id, :name)
  end

  def create
    ActiveRecord::Base.transaction do
      for i in 1..params[:count].to_i do 
        ZoneJobProfileDoc.create(
          zone_job_profile_id: params[:zone_job_profile_id],
          d_type: params[:d_type],
          document_id: params["document_#{i}".to_sym].to_i,
          start_date: params["start_date_#{i}".to_sym]
        )
      end
      render json: { status: :success, msg: 'Asociacion exitosa' }, status: :ok
    end
    rescue ActiveRecord::RecordInvalid
      render json: { status: :error, msg: 'No al agregar los perfiles y zonas' }, status: :unprocessable_entity
  end

  def update
  end
end
