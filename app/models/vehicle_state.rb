# == Schema Information
#
# Table name: vehicle_states
#
#  id                    :bigint           not null, primary key
#  vehicle_id            :bigint
#  cost_center_id        :bigint
#  sub_zone_id           :bigint
#  operator_id           :bigint
#  client_id             :bigint
#  start_date            :date
#  end_date              :date
#  active                :boolean          default(TRUE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  assignation_status_id :bigint
#
class VehicleState < ApplicationRecord
  belongs_to :vehicle
  belongs_to :cost_center
  belongs_to :sub_zone
  belongs_to :assignation_status
  
  belongs_to :operator, optional: true
  belongs_to :client, optional: true
  has_many :vehicle_state_clients, dependent: :destroy
  has_many :vehicle_state_operators, dependent: :destroy

  has_many :clients, through: :vehicle_state_clients
  has_many :operators, through: :vehicle_state_operators

  validates :start_date, presence: !:end_date.blank?
  validates :end_date, presence: !:start_date.blank?

  validate :vehicle_blocked, :create_blocked_state, :valid_dates
  after_create :update_documents
  before_validation :set_sub_zone
  accepts_nested_attributes_for :vehicle_state_clients, :vehicle_state_operators

  scope :actives, -> { where(active: true) }

  def self.check_dates(vehicle_id, start_date, end_date)
    state = VehicleState.where( 'vehicle_states.vehicle_id': vehicle_id )


      state.where('vehicle_states.start_date BETWEEN ? AND ?', start_date, end_date)
      .or(VehicleState.where('vehicle_states.end_date BETWEEN ? AND ?', start_date, end_date))
  end

  private
  def vehicle_blocked #el vehiculo se encuentra bloqueado en esas fechas
    blocked = VehicleState
              .where( 'vehicle_states.vehicle_id': self.vehicle_id )
              .where('vehicle_states.start_date BETWEEN ? AND ?', self.start_date, self.end_date)
              .or( VehicleState.where('vehicle_states.end_date BETWEEN ? AND ?', self.start_date, self.end_date) )
              .joins(:assignation_status)
              .where('assignation_statuses': { blocks: true })
    if !blocked.blank?
      errors.add(:start_date, "La unidad se encuentra #{blocked.assignation_status.name} en esas fechas")
      errors.add(:end_date, "La unidad se encuentra #{blocked.assignation_status.name} en esas fechas")
    end
  end

  def create_blocked_state # se quiere asignar al vehiculo un estado bloqueante y esta ocupado en esas fechas
    state = AssignationStatus.find(self.assignation_status_id)
    if state.blocks?
      blocked = VehicleState
              .where( 'vehicle_states.vehicle_id': self.vehicle_id )
              .where('vehicle_states.start_date BETWEEN ? AND ?', self.start_date, self.end_date)
              .or(VehicleState.where('vehicle_states.end_date BETWEEN ? AND ?', self.start_date, self.end_date))
              .joins(:assignation_status)
      if !blocked.blank?
        errors.add(:start_date, "La unidad se encuentra asignada en esas fechas")
        errors.add(:end_date, "La unidad se encuentra asignada en esas fechas")
        errors.add(:base, "No puede asignar al vehiculo un estado que bloquea si se encuentra asignado en esas fechas")
      end
    end
  end

  def valid_dates
    errors.add(:start_date, "La fecha de inicio no puede ser mayor a la de fin") if self.start_date > self.end_date
  end

  def update_documents
    assignment = AssignmentsCostCenter.where( cost_center_id: self.cost_center_id, 
      assignated: self.vehicle )
    byebug
    if assignment.blank?
      puts 'blank'
      AssignmentsCostCenter.create( cost_center_id: self.cost_center_id, 
      assignated: self.vehicle )
    else
      puts 'update'
      assignment.assign_documents
    end
    byebug
  end

  def set_sub_zone
    self.sub_zone_id = self.cost_center.zone.id
  end

end
