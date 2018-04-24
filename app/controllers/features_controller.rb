# frozen_string_literal: true

# Features controller responds to /features requests
class FeaturesController < ApplicationController
  def index
    @people = Person.all
    @features = Feature.all
  end

  def show
    @feature = Feature.find(params[:id])
  end
end
