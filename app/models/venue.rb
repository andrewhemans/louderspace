class Venue < ApplicationRecord
    # Geocoding
    geocoded_by :full_address
    after_validation :geocode, if: ->(obj){ obj.address_changed? || obj.city_changed? || obj.state_changed? }
  
    # Association with Event
    has_many :events
  
    # Method to concatenate address components
    def full_address
      "#{address}, #{city}, #{state}"
    end
  
    # Other venue-related logic...
  end
