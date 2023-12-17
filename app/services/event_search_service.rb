class EventSearchService
    def initialize(city, state, distance, genre_id)
      @city = city
      @state = state
      @distance = distance
      @genre_id = genre_id
    end
  
    def search
      events = Event.includes(:venue, :genres)
  
      if @city.present? && @state.present?
        city_coordinates = Geocoder.coordinates("#{@city}, #{@state}")
        if city_coordinates
          distance = @distance.present? ? @distance.to_i : 10 # Default distance
          nearby_venues = Venue.near(city_coordinates, distance, order: false)
          nearby_venue_ids = nearby_venues.pluck(:id)
          events = events.joins(:venue).where(venues: { id: nearby_venue_ids })
        end
      end
  
      if @genre_id.present?
        events = events.joins(:genres).where(genres: { id: @genre_id })
      end
  
      events
    end
  end
  