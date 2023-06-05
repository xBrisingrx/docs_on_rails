class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[ edit update destroy ]

  def index
    @assignments = Assignment.all.order(start_date)
  end

  def people;end

  def vehicles 
    @assignments = Assignment.for_vehicles.actives
    @table_cols = [ 'Interno', 'Dominio', 'Estado','Desde','Hasta','Empresa', 'Centro de costo', 'Subcentro', 'Operadora','Cliente' ]
  end

  def show
    if params[:assignated] == 'person'
      data = Person.find params[:id]
    elsif params[:assignated] == 'vehicle'
      data = Vehicle.find params[:id]
    else 
      # 
    end
    @assignment_cost_centers = data.assignments
  end

  def new
    @assignment = Assignment.new
    if params[:assignated_type] == 'vehicle'
      @assignated_type = 'Vehicle'
      @title_modal = 'Asignar vehiculo'
      @cost_centers = CostCenter.actives.where(d_type: :vehicles)
      @assignateds = Vehicle.actives
      @assignation_statuses = AssignationStatus.where(d_type: :vehicles).actives.order(:name)
    end
  end

  def edit
  end

  def create
    @assignment = Assignment.new(assignment_params)
    respond_to do |format|
      if @assignment.save
        format.json { render json: { status: 'success', msg: 'Asignacion registrada'}, status: :created }
        format.html { redirect_to assignment_url(@assignment), notice: "Exito." }
      else
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to assignment_url(@assignment), notice: "Assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignments_url, notice: "Assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_dates
    state = Assignment.check_dates(params[:assignated_type],params[:assignated_id],params[:start_date], params[:end_date])
    if state.blank?
      render json: { status: 'available' }
    else
      msg = ''
      msg = state.map { |s| msg.concat("<li>La unidad se encuentra de <b>#{ s.assignation_status.name }</b> desde <b>#{s.start_date.strftime('%d-%m-%y')}</b> hasta <b>#{s.end_date.strftime('%d-%m-%y')}</b></li>") }
      render json: { status: 'not_available', msg: msg }
    end
  end 

  private
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def assignment_params
      params.require(:assignment).permit(:assignated_id, :assignated_type, :cost_center_id, 
          :assignation_status_id, :start_date, :end_date,
          assignment_clients_attributes: [ :id, :client_id ],
          assignment_operators_attributes: [ :id, :operator_id ])
    end
end
