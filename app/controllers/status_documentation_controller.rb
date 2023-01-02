class StatusDocumentationController < ApplicationController
  def index

  end

  def people
    @people = Person.actives
  end

  def vehicules
    
  end
end
