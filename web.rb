#!/usr/bin/env ruby

require "sinatra"
require_relative "./lib/nishitetsu"

set :bind, '0.0.0.0'
set :port, ENV["PORT"] || 4567

# TODO: get these from nishitetsu search API
bus_stops = {
  "福岡女子大前" => "0001,660102",
  "天神三丁目" => "0000,D00118",
  "天神地区" => "0000,L00001",
  "天神中央郵便局前" => "0000,D11122",
}

api = Api.new

get "/" do
  redirect "/to_tenjin"
end

get "/to_tenjin" do
  html = api.live_departures(
    from: bus_stops["福岡女子大前"],
    to: bus_stops["天神三丁目"],
  )

  dp = DeparturesParser.new(html)
  erb :departures, locals: { dp: dp }
end

get "/from_tenjin" do
  html = api.live_departures(
    to: bus_stops["福岡女子大前"],
    from: bus_stops["天神中央郵便局前"],
  )

  dp = DeparturesParser.new(html)
  erb :departures, locals: { dp: dp }
end

