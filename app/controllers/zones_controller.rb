class ZonesController < ApplicationController
  before_action :set_zone, only: %i[ show edit update destroy ]

  # GET /zones or /zones.json
  def index
    @title_modal = 'Zonas registradas'
    @zones = Zone.all
    @zone = Zone.new
  end

  # GET /zones/1 or /zones/1.json
  def show
  end

  # GET /zones/new
  def new
    @title_modal = 'Registrar zona'
    @zone = Zone.new
  end

  # GET /zones/1/edit
  def edit
  end

  # POST /zones or /zones.json
  def create
    @zone = Zone.new(zone_params)

    respond_to do |format|
      if @zone.save
        format.json { render json: { status: 'success', msg: 'Zona registrada'}, status: :created }
        format.html { redirect_to zone_url(@zone), notice: "Zone was successfully created." }
      else
        format.json { render json: @zone.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zones/1 or /zones/1.json
  def update
    respond_to do |format|
      if @zone.update(zone_params)
        format.json { render json: { status: 'success', msg: 'Zona actualizada'}, status: :ok }
        format.html { redirect_to zone_url(@zone), notice: "Zone was successfully updated." }
      else
        format.json { render json: @zone.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zones/1 or /zones/1.json
  def destroy
    @zone.destroy

    respond_to do |format|
      format.html { redirect_to zones_url, notice: "Zone was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zone
      @zone = Zone.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def zone_params
      params.require(:zone).permit(:name, :code, :description, :active)
    end
end
