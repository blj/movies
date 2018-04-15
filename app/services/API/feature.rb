# frozen_string_literal: true

# Feature index resource http://34.216.164.119/features
# returns ids in JSON array
# [1,2,3,4,5,6,7]

# Feature single resource http://34.216.164.119/features/1
# returns item attribute {"id":1,"title":"Hot Fuzz","release":2000,"director":1,"cast":[2,3,4]}
# non existent resource id returns 404 status code

class API::Feature
  # site = 'http://34.216.164.119/'  
  def self.ids
    API::Connection.get('/features')
  end
  def self.get(id)
    API::Connection.get("/features/#{id}").tap do |attrs|
      pp attrs
      unless attrs.blank?
        attrs[:director_id] = attrs.delete(:director)
        attrs[:actor_ids] = attrs.delete(:cast)
      end
    end
  end
end
