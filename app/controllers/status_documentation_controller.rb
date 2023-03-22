class StatusDocumentationController < ApplicationController
  def index

  end

  def people
    @people = Person.actives
  end

  def vehicles
    @vehicles = Vehicle.actives
  end
end
