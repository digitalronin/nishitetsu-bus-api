#!/usr/bin/env ruby

require "debug"

require "time"
require "nokogiri"

require_relative "../lib/nishitetsu"

doc = File.open("stop-departures.html") { |f| Nokogiri::XML(f) }

departures = doc.css("div.cassette").map { |node| Departure.new(node) }

puts

departures.each do |d|
  puts [
    "Route: #{d.route_number} (#{d.route_type})",
    "Expected in: #{d.expected_in} minutes (Due: #{d.scheduled_departure})",
    "Should arrive at: #{d.expected_arrival}",
    " ",
  ].join("\n")
end
