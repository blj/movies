class FeaturesController < ApplicationController
  def index
    @features = Feature.all(filter)
  end
  def show
    @feature = Feature.find(params[:id])
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
