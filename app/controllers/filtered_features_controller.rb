class FilteredFeaturesController < ApplicationController
  include FilterFeature
  def create
    @people = Person.all
    @features = filter Feature.all
    @filter_params = OpenStruct.new(filter_params)
    render 'features/index'
  end
  private
  def filter_params
    params.require(:filter).permit(:director_id, any_actor_ids: [], all_actor_ids: [])
  end
end