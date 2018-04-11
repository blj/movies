class Feature 
  include ActiveModel::Model
  attr_accessor :id, :title, :release, :director, :cast
  def self.all
    API::Feature.ids.map do |feature_id|
      find(feature_id)
    end
  end
  def self.find(feature_id)
    new API::Feature.get(feature_id)
  end
end
