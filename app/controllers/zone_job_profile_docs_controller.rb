class ZoneJobProfileDocsController < ApplicationController
  before_action :set_zone_job_profile_doc, only: %i[ modal_disable modal_reactive ]
  def index
    # @entries = ZoneJobProfileDoc.where( d_type: params[:d_type])
    @entries = ZoneJobProfileDoc.joins(:zone_job_profile)
                                .select("zone_job_profile_docs.id, zone_job_profile_docs.document_id,zone_job_profile_docs.zone_job_profile_id,
                                  zone_job_profile_docs.start_date, zone_job_profile_docs.end_date,zone_job_profile_docs.active,zone_job_profiles.active as e_active")
                                .where( zone_job_profiles: {active: true} )
                                .where(d_type: params[:d_type])
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
        entry = ZoneJobProfileDoc.new(
          zone_job_profile_id: params[:zone_job_profile_id],
          d_type: params[:d_type],
          document_id: params["document_#{i}".to_sym].to_i,
          start_date: params["start_date_#{i}".to_sym]
        )
        entry.assignment_documents_to_profile
      end
      entry.update_asociations
      render json: { status: :success, msg: 'Asociacion exitosa' }, status: :ok
    end
    rescue StandardError => e
      render json: { status: :info, msg: e.message }, status: :ok
    rescue ActiveRecord::RecordInvalid
      render json: { status: :error, msg: 'No se pudieron asociar los documentos' }, status: :unprocessable_entity
  end

  def update
  end

  def modal_disable;end

  def disable
   @zone_job_profile_doc = ZoneJobProfileDoc.find(params[:id])
    respond_to do |format|
      if @zone_job_profile_doc.disable(params[:end_date])
        format.json { render json: { msg: 'Operacion exitosa', status: 'success' }, status: :ok }
      else
        format.json { render json: { msg: 'Ocurrio un error al realizar la operacion' }, status: :unprocessable_entity }
      end
    end
  end

  def modal_reactive;end

  def reactive
    @zone_job_profile_doc = ZoneJobProfileDoc.find(params[:id])
    respond_to do |format|
      if @zone_job_profile_doc.reactive(params[:start_date])
        format.json { render json: { msg: 'Operacion exitosa', status: 'success' }, status: :ok }
      else
        format.json { render json: { msg: 'Ocurrio un error al realizar la operacion' }, status: :unprocessable_entity }
      end
    end
  end

 private

  def set_zone_job_profile_doc
    @zone_job_profile_doc = ZoneJobProfileDoc.find(params[:id])
  end

end
