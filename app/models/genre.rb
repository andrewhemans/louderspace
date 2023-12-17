class Genre < ApplicationRecord
    # Many-to-many association with Event through a join table
    has_many :event_genres
    has_many :events, through: :event_genres
  
    # Other genre-related logic...
  end
