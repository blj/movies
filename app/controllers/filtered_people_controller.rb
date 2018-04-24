# frozen_string_literal: true

require 'set'

# FilteredPeopleController filters people acted in chosen movies
class FilteredPeopleController < ApplicationController
  def create
    @people = Person.find filter params[:feature_ids]
    @title = Feature.find(params[:feature_ids]).map(&:title).to_sentence
    @title = "Common Actors in #{@title}"
    render 'people/index'
  end

  private

  def filter(feature_ids)
    feature_sets = Feature.find(feature_ids).map do |feature|
      Set.new(feature.actor_ids)
    end
    feature_sets.reduce do |common_set, set|
      common_set.intersection set
    end.to_a
  end
end
