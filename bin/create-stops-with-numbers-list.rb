#!/usr/bin/env ruby

# Script to process the JSON files in data/bus-numbers and combine them into
# data/fukuoka-bus-stops-with-routes.json
#
# This assumes that data/bus-numbers/*.json contains exactly one file for each
# fukuoka bus stop.

require "json"

list = []

Dir["data/bus-numbers/*.json"].each do |file|
  data = JSON.parse(File.read(file))
  list.push(data) if data["ROUTE_NUMBERS"].any?
end

File.write("data/fukuoka-bus-stops-with-routes.json", list.to_json)
