class Event < ApplicationRecord
  # Association with Venue
  belongs_to :venue

  # Many-to-many association with Genre through a join table
  has_many :event_genres
  has_many :genres, through: :event_genres

  # Other event-related logic...
end