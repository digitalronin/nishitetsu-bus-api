#!/usr/bin/env ruby

# Script to create data/bus-data.json from data/fukuoka-bus-stops-with-routes.json

require "debug"
require "json"

data = {}

bus_stops = JSON.parse(File.read("data/fukuoka-bus-stops-with-routes.json"))

route_numbers = bus_stops.map {|b| b["ROUTE_NUMBERS"]}.flatten.uniq

routes = {}

route_numbers.each do |r|
  routes[r] = bus_stops
    .filter {|b| b["ROUTE_NUMBERS"].include?(r)}
    .map {|b| b["TEI_CD"]}.sort
end

data["bus_stops"] = bus_stops
data["routes"] = routes

File.write("data/bus-data.json", data.to_json)
