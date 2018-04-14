class Person < Base
  include ActiveModel::Model
  attr_accessor :id, :name, :feature_ids
  def to_s
    name
  end
  def self.resource
    raise NotImplementedError
  end
end
