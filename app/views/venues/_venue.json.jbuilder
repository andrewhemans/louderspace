json.extract! venue, :id, :name, :address, :city, :state, :latitude, :longitude, :created_at, :updated_at
json.url venue_url(venue, format: :json)
