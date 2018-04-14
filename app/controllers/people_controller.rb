class PeopleController < ApplicationController
  def index
    @people = [Person.new(name: 'Simon Pegg')]
  end
end
