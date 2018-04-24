# frozen_string_literal: true

# PeopleController lists actors and directors
class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
  end
end
