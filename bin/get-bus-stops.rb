#!/usr/bin/env ruby

require "debug"

# Script to iterate over a map grid and retrieve Nishitetsu bus stop
# JSON data from their API.

require "cgi"
require "digest"
require_relative "../lib/nishitetsu"

MIN_LATITUDE  = 33.34210577252230
MAX_LATITUDE  = 33.88467831141420
MIN_LONGITUDE = 130.272245026617
MAX_LONGITUDE = 130.724079057735
STEP_SIZE = 0.01

def fetch_and_store(lat:, lon:)
  key = [lat, lon].join(", ")
  puts "Fetching: #{key}"
  api = Api.new
  json = api.bus_stops_near_location(lat: lat, lon: lon, area: STEP_SIZE)
  filename = "data/bus-stops/#{Digest::SHA256.hexdigest(key)}.json"
  File.write(filename, json)
end

(MIN_LONGITUDE..MAX_LONGITUDE).step(STEP_SIZE).each do |lon|
  (MIN_LATITUDE..MAX_LATITUDE).step(STEP_SIZE).each do |lat|
    fetch_and_store(lat: lat, lon: lon)
    sleep 1
  end
end
