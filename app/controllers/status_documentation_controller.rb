class StatusDocumentationController < ApplicationController
  def index

  end

  def people
    @people = Person.actives
    @assgined_type = 'people'
    @type = 'persona'
  end

  def vehicles
    @vehicles = Vehicle.actives.order(code: 'ASC')
    @assgined_type = 'vehicles'
    @type = 'unidad'
  end
end
