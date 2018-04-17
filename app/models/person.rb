class Person < Base
  attr_accessor :name, :feature_ids, :directed_ids, :acted_ids
  build_using API::Actor, Proc.new {|attrs|
    attrs[:acted_ids] = attrs.delete(:feature_ids) unless attrs.blank?
    attrs
  }
  build_using API::Director, Proc.new { |attrs|
    attrs[:directed_ids] = attrs.delete(:feature_ids) unless attrs.blank?
    attrs
  }
  def to_s
    name
  end
  def features_acted
    unless acted_ids.blank?
      acted_ids.collect do |id|
        Feature.find(id)
      end
    end
  end
  def features_directed
    unless directed_ids.blank?
      directed_ids.collect do |id|
        Feature.find(id)
      end
    end
  end
end
