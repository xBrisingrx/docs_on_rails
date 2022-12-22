class Person < ApplicationRecord
  belongs_to :company
  has_one_attached :dni_file
  has_one_attached :cuil_file
  has_one_attached :start_activity_file

  validates :file, presence: true, uniqueness: true
  validates :name, presence: true, length: { minimum: 3, too_short: "Minimo son %{count} caracteres." }
  validates :last_name, presence: true, length: { minimum: 3, too_short: "Minimo son %{count} caracteres." }
  validates :dni, presence: true, uniqueness: { message: "Este dni pertenece a otra persona" },
    length: { minimum: 8, too_short: "Minimo son %{count} caracteres." }
  validates :email,
    uniqueness: { case_sensitive: false, message: "El email ya se encuentra en uso" }, 
    allow_blank: true,
    format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }

  validates :tramit_number, uniqueness: { message: "Este número de tramite pertenece a otra persona" }, 
    allow_blank: true

  scope :actives, -> { where(active: true) }

  def fullname
    "#{self.last_name} #{self.name}"  
  end

  def set_company
    self.company_id = 1
  end
  
end
