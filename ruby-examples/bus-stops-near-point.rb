#!/usr/bin/env ruby

require "net/http"

uri = URI("http://busnavi01.nishitetsu.ne.jp/map")

http = Net::HTTP.new(uri.host)
request = Net::HTTP::Post.new(uri.request_uri)

form_data = URI.encode_www_form({
      f: "maptei",
      lat: 33.6631434,
      lon: 130.4389057,
      area: 0.1,
      tei_type: [0,1],
})

request.body = form_data
res = http.request(request)

puts res.body
