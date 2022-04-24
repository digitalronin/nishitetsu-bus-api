#!/usr/bin/env ruby

require "debug"

require "time"
require "net/http"
require "cgi"
require "nokogiri"

require_relative "../lib/nishitetsu"

API_URL = "http://busnavi01.nishitetsu.ne.jp"

def get_live_departures
  Net::HTTP.get(URI(api_url))
end

def api_url
  params = {
    f_zahyo_flg: 0,
    f_list: "0001,660102",
    t_zahyo_flg: 0,
    t_list: "0000,L00001",
    rightnow_flg: 2,
    stime_flg: 1,
    jkn_busnavi: 1,
    syosaiFlg: 0,
  }

  querystring = params.map {|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join("&")

  "#{API_URL}/route?#{querystring}"
end

html = get_live_departures
doc = Nokogiri::HTML(html)
#File.write("foo.html", html)

# doc = File.open("foo.html") { |f| Nokogiri::XML(f) }

departures = doc.css("div.cassette")
  .map { |node| Departure.new(node) }
  .sort { |a,b| a.expected_in <=> b.expected_in }

puts

departures.each do |d|
  expected = d.expected_departure.strftime("%H:%M")
  arrival = d.expected_arrival.strftime("%H:%M")
  puts [
    "Route: #{d.route_number} (#{d.route_type})",
    "Expected in: #{d.expected_in} minutes (Due: #{d.scheduled_departure}, Expected: #{expected})",
    "Should arrive at: #{arrival}",
    " ",
  ].join("\n")
end
