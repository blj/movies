class Feature < Base
  attr_accessor :title, :release, :director_id, :actor_ids, :director, :actors
  build_using API::Feature
  after_find :load_associations
  def to_s
    title
  end
  private
  def load_associations
    self.director = Person.find(director_id) unless director_id.blank?
    self.actors = Person.find(actor_ids) unless actor_ids.blank?
  end
end
