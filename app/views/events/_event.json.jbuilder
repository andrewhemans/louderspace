json.extract! event, :id, :name, :date, :description, :venue_id, :created_at, :updated_at
json.url event_url(event, format: :json)
