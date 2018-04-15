# frozen_string_literal: true

# Director index resource http://34.216.164.119/directors
# returns ids in JSON array
# [1,2,10]

# Director single resource http://34.216.164.119/directors/1
# returns item attribute {"id":1,"name":"Edgar Wright","movies":[1,3,4,5]}
# non existent resource id returns 404 status code

class API::Director
  # site = 'http://34.216.164.119/'  
  def self.ids
    API::Connection.get('/directors')
  end
  def self.get(id)
    API::Connection.get("/directors/#{id}").tap do |attrs|
      attrs['feature_ids'] = attrs.delete('movies') unless attrs.blank?
    end
  end
end
