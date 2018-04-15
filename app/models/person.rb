class Person < Base
  include ActiveModel::Model
  attr_accessor :id, :name, :feature_ids
  build_using API::Actor
  build_using API::Director
  def to_s
    name
  end
end
