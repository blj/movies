class Person < Base
  attr_accessor :name, :feature_ids, :directed_ids, :acted_ids
  build_using API::Actor, process_attributes: :set_acted
  build_using API::Director, process_attributes: :set_directed
  def to_s
    name
  end
  def directed_ids
    feature_ids
  end
  private
  def set_actor(attrs)
    acted_ids = attrs[:movies]
  end
  def set_director
    directed_ids = attrs[:movies]
  end
end
