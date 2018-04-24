# frozen_string_literal: true

# Person is the model for an actor or a director
class Person < Base
  attr_accessor :name, :feature_ids, :directed_ids, :acted_ids
  build_using API::Actor, (proc { |attrs|
    attrs[:acted_ids] = attrs.delete(:feature_ids) unless attrs.blank?
    attrs
  })
  build_using API::Director, (proc { |attrs|
    attrs[:directed_ids] = attrs.delete(:feature_ids) unless attrs.blank?
    attrs
  })
  def to_s
    name
  end

  def features_acted
    return [] if acted_ids.blank?
    acted_ids.collect do |id|
      Feature.find(id)
    end
  end

  def features_directed
    return [] if directed_ids.blank?
    directed_ids.collect do |id|
      Feature.find(id)
    end
  end
end
