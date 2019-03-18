require "httparty"
require "dotenv"
require "awesome_print"

Dotenv.load

#Starter Code:
seven_wonders = ["Great Pyramid of Giza", "Hanging Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

BASE_URL = "https://us1.locationiq.com/v1/search.php"
key = ENV["LOCATION_IQ_KEY"]

seven_wonders_locations = seven_wonders.map do |wonder|
  sleep(1)
  query_parameters = {
    q: wonder,
    key: key,
    format: "json",
  }
  response = HTTParty.get(BASE_URL, query: query_parameters)
  { wonder => { "lat" => response[0]["lat"], "lon" => response[0]["lon"] } }
end

seven_wonders_locations = seven_wonders_locations.reduce({}) {
  |location_hash, hash|
  hash.merge(location_hash)
}

ap seven_wonders_locations

BASE_URL_2 = "https://us1.locationiq.com/v1/reverse.php"

coordinates = [{ lat: 38.8976998, lon: -77.0365534886228 }, { lat: 48.4283182, lon: -123.3649533 }, { lat: 41.8902614, lon: 12.493087103595503 }]
location_names = coordinates.map do |location|
  sleep(1)
  query_parameters = {
    lat: location[:lat],
    lon: location[:lon],
    key: key,
    format: "json",
  }
  response = HTTParty.get(BASE_URL_2, query: query_parameters)
  response["display_name"]
end

ap location_names
#Example Output:
#{"Great Pyramind of Giza"=>{"lat"=>29.9792345, "lng"=>31.1342019}, "Hanging Gardens of Babylon"=>{"lat"=>32.5422374, "lng"=>44.42103609999999}, "Colossus of Rhodes"=>{"lat"=>36.45106560000001, "lng"=>28.2258333}, "Pharos of Alexandria"=>{"lat"=>38.7904054, "lng"=>-77.040581}, "Statue of Zeus at Olympia"=>{"lat"=>37.6379375, "lng"=>21.6302601}, "Temple of Artemis"=>{"lat"=>37.9498715, "lng"=>27.3633807}, "Mausoleum at Halicarnassus"=>{"lat"=>37.038132, "lng"=>27.4243849}}
