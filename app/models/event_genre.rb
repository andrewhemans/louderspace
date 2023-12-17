class EventGenre < ApplicationRecord
  belongs_to :event
  belongs_to :genre

  # Any additional logic for the join table...
end