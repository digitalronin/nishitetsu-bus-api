#!/usr/bin/env ruby

require_relative "../lib/nishitetsu"

api = Api.new
html = api.live_departures
dp = DeparturesParser.new(html)

puts
puts "From: #{dp.journey_start}, To: #{dp.journey_end}"
puts

dp.departures.each do |d|
  expected = d.expected_departure.strftime("%H:%M")
  arrival = d.expected_arrival.strftime("%H:%M")
  puts [
    "Route: #{d.route_number} (#{d.route_type})",
    "Expected in: #{d.expected_in} minutes (Due: #{d.scheduled_departure}, Expected: #{expected})",
    "Should arrive at: #{arrival}",
    " ",
  ].join("\n")
end
