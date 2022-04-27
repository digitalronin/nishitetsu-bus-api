#!/usr/bin/env ruby

# Script to iterate over all fukuoka bus stops, and fetch all the bus route
# numbers which stop at each one.

require_relative "../lib/nishitetsu"

bus_stops = JSON.parse(File.read("data/fukuoka-bus-stops.json"))

bus_stops.each do |bus_stop|
  key = [bus_stop["JIGYOSHA_CD"], bus_stop["TEI_CD"]].join(",")
  filename = "data/bus-numbers/#{Digest::SHA256.hexdigest(key)}.json"

  if FileTest.exists?(filename)
    puts "Already fetched data for #{key}"
  else
    puts "Fetching: #{key}"
    html = Api.new.bus_routes_for_stop(key)
    doc = Nokogiri::HTML(html)

    bus_stop["ROUTE_NUMBERS"] = doc.css("li.num").map(&:text).uniq
    File.write(filename, bus_stop.to_json)
    sleep 1
  end
end
