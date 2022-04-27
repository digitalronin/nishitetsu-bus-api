#!/usr/bin/env ruby

# Script to process the JSON files in data/bus-stops and extract
# unique, fukuoka bus stops. The script creates data/fukuoka-bus-stops.json
# as a complete list.

require "json"

list = []
in_list = {}

Dir["data/bus-stops/*.json"].each do |file|
  data = JSON.parse(File.read(file))
  fukuoka_stops = data["List"].filter { |stop| stop["AREA_TYPE"] == "fukuoka" }
  fukuoka_stops.each do |stop|
    key = stop.hash
    if !in_list[key]
      list.push(stop)
      in_list[key] = true
    end
  end
end

File.write("data/fukuoka-bus-stops.json", list.to_json)
