require 'faker'
# Predefined list of real US cities with latitude and longitude
us_cities = [
  { city: 'San Francisco', state: 'CA', latitude: 37.7749, longitude: -122.4194 },
  { city: 'Stockton', state: 'CA', latitude: 37.9577, longitude: -121.2908 },
  { city: 'New York', state: 'NY', latitude: 40.7128, longitude: -74.0060 },
  { city: 'Los Angeles', state: 'CA', latitude: 34.0522, longitude: -118.2437 },
  { city: 'Chicago', state: 'IL', latitude: 41.8781, longitude: -87.6298 },
  { city: 'Houston', state: 'TX', latitude: 29.7604, longitude: -95.3698 },
  { city: 'Phoenix', state: 'AZ', latitude: 33.4484, longitude: -112.0740 },
  { city: 'Philadelphia', state: 'PA', latitude: 39.9526, longitude: -75.1652 },
  { city: 'San Antonio', state: 'TX', latitude: 29.4241, longitude: -98.4936 },
  { city: 'San Diego', state: 'CA', latitude: 32.7157, longitude: -117.1611 }
]

# Create Venues
us_cities.each do |city_info|
  Venue.create(
    name: Faker::Company.name,
    address: Faker::Address.street_address,
    city: city_info[:city],
    state: city_info[:state],
    latitude: city_info[:latitude],
    longitude: city_info[:longitude]
  )
end

# Create Genres
genres = %w(Rock Pop Jazz Hip-Hop Country Blues Electronic Folk Indie Metal)

genres.each do |genre_name|
  Genre.create(name: genre_name)
end

# Create Events with Associated Venues and Genres
25.times do
  event_name = Faker::Music.unique.band + ", " + Faker::Music.unique.band
  venue = Venue.offset(rand(Venue.count)).first
  random_genre_ids = Genre.pluck(:id).sample(rand(1..3))

  event = Event.create(
    name: event_name,
    date: Faker::Date.forward(days: 30),
    time: Faker::Time.forward(days: 30, period: :evening),
    description: Faker::Lorem.sentence(word_count: 6),
    venue: venue,
    genre_ids: random_genre_ids
  )
end

# Create 25 bands with random names, biographies, city, and state
25.times do
  band_name = Faker::Music.unique.band
  custom_path = band_name.gsub(' ', '').downcase

  Band.create(
    name: band_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    custom_path: custom_path
  )
end
