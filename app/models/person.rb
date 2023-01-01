class Person < ApplicationRecord
  has_one_attached :dni_file
  has_one_attached :cuil_file
  has_one_attached :start_activity_file
  has_many :assignments_profiles, as: :assignated # relacion entre perfil y persona
  has_many :profiles, through: :assignments_profiles
  has_many :assignments_documents, as: :assignated
  has_many :documents, through: :assignments_documents

  validates :file, presence: true, uniqueness: { message: "Este legajo pertenece a otra persona" }
  validates :name, presence: true, length: { minimum: 3, too_short: "Minimo son %{count} caracteres." }
  validates :last_name, presence: true, length: { minimum: 3, too_short: "Minimo son %{count} caracteres." }
  validates :dni, uniqueness: { message: "Este dni pertenece a otra persona" },
    allow_blank: true,
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
end
