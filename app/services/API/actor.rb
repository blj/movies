# frozen_string_literal: true

# Actor index resource http://34.216.164.119/actors
# returns ids in JSON array
# [2,3,4,5,6,7,8,9,11,12,13,14]

# Actor single resource http://34.216.164.119/actors/2
# returns item attribute {"id":2,"name":"Simon Pegg","movies":[1,2,3,4,6]}
# non existent resource id returns 404 status code

class API::Actor
  # site = 'http://34.216.164.119/'  
  def self.ids
    API::Connection.get('/actors')
  end
  def self.get(id)
    API::Connection.get("/actors/#{id}").tap do |attrs|
      attrs["feature_ids"] = attrs.delete("movies")
    end
  end
end
