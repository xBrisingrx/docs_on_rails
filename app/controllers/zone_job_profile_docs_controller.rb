class ZoneJobProfileDocsController < ApplicationController
  def index
    @entries = ZoneJobProfileDoc.where( d_type: params[:d_type])
  end

  def new
  end

  def create
  end

  def update
  end
end
