class Feature < Base
  attr_accessor :title, :release, :director_id, :actor_ids
  build_using API::Feature
  def director
    Person.find(director_id)
  end
  def actors
    Person.find(actor_ids)
  end
  def to_s
    title
  end
end
