class ZoneJobProfileDocsController < ApplicationController
  def index
    @entries = ZoneJobProfileDoc.where( d_type: params[:d_type])
  end

  def new
    @zone_job_profile_doc = ZoneJobProfileDoc.new
    @title_modal = 'Agregar documento a un perfil'
    @profiles = ZoneJobProfile.where( d_type: params[:d_type]).actives
    @documents = Document.where( d_type: params[:d_type]).actives.pluck(:id, :name)
  end

  def create
  end

  def update
  end
end
