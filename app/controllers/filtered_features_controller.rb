class FilteredFeaturesController < ApplicationController
  def create
    @people = Person.all
    @features = Feature.all(filter)
    render 'features/index'
  end
  private
  def filter
    {}.tap do |options|
      unless params[:director].blank?
        options[:filter_using] = :director_id
        options[:filter_value] = params[:director]
      end
    end
  end
end