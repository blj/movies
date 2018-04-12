class Director < Base
  attr_accessor :id, :name, :feature_ids
  def self.resource
    API::Director
  end
  def to_s
    name
  end
end
