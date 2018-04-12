class Feature < Base
  attr_accessor :id, :title, :release, :director_id, :actor_ids, :director, :actors 
  def self.resource
    API::Feature
  end
  after_find :load_associations
  def to_s
    title
  end
  private
  def load_associations
    self.director = Director.find(director_id)
    self.actors = Actor.find(actor_ids)
  end
end
