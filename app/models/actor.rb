class Actor < Base
  attr_accessor :id, :name, :feature_ids
  def self.resource
    API::Actor
  end
  def to_s
    name
  end
end
