class DocumentRenovationsController < ApplicationController
  before_action :set_document_renovation, only: %i[ show edit update destroy ]

  # GET /document_renovations or /document_renovations.json
  def index
    @document_renovations = DocumentRenovation.all
  end

  # GET /document_renovations/1 or /document_renovations/1.json
  def show
  end

  # GET /document_renovations/new
  def new
    @document_renovation = DocumentRenovation.new
  end

  # GET /document_renovations/1/edit
  def edit
  end

  # POST /document_renovations or /document_renovations.json
  def create
    @document_renovation = DocumentRenovation.new(document_renovation_params)

    respond_to do |format|
      if @document_renovation.save
        format.html { redirect_to document_renovation_url(@document_renovation), notice: "Document renovation was successfully created." }
        format.json { render :show, status: :created, location: @document_renovation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document_renovation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_renovations/1 or /document_renovations/1.json
  def update
    respond_to do |format|
      if @document_renovation.update(document_renovation_params)
        format.html { redirect_to document_renovation_url(@document_renovation), notice: "Document renovation was successfully updated." }
        format.json { render :show, status: :ok, location: @document_renovation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document_renovation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_renovations/1 or /document_renovations/1.json
  def destroy
    @document_renovation.destroy

    respond_to do |format|
      format.html { redirect_to document_renovations_url, notice: "Document renovation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_renovation
      @document_renovation = DocumentRenovation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_renovation_params
      params.require(:document_renovation).permit(:renovation_date, :expiration_date, :active, :comment, :assignments_document)
    end
end
