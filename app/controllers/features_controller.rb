class FeaturesController < ApplicationController
  def index
    @features = Feature.all(filter)
  end
  def show
    @feature = Feature.find(params[:id])
  end
  private
  def filter
    unless params[:filter_using].blank?
      {
        filter_using: params[:filter_using],
        filter_value: params[:filter_value]
      }
    end
  end
end
