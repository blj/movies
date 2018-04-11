class Feature < Base
  attr_accessor :id, :title, :release, :director_id, :actor_ids, :director, :actors 
  def self.resource
    API::Feature
  end
end
