class Api
  API_URL = "http://busnavi01.nishitetsu.ne.jp"

  def initialize()
    # TODO
  end

  # Returns HTML
  def live_departures(from:, to:)
    Net::HTTP.get(URI(departures_url(from: from, to: to)))
  end

  def bus_stops_near_location(lat:, lon:, area:)
    Net::HTTP.get(URI(bus_stop_map_url(lat: lat, lon: lon, area: area)))
  end

  private

  def bus_stop_map_url(lat:, lon:, area:)
    params = {
      f: "maptei",
      lat: lat,
      lon: lon,
      area: area,
    }

    arr = params.map {|k,v| "#{k}=#{CGI.escape(v.to_s)}"}

    arr += [
      CGI.escape("tei_type[]=0"),
      CGI.escape("tei_type[]=1"),
    ]

    querystring = arr.join("&")

    "#{API_URL}/map?#{querystring}"
  end

  def departures_url(from:, to:)
    params = {
      f_zahyo_flg: 0,
      f_list: from,
      t_zahyo_flg: 0,
      t_list: to,
      rightnow_flg: 2,
      stime_flg: 1,
      jkn_busnavi: 1,
      syosaiFlg: 0,
    }

    querystring = params.map {|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join("&")

    "#{API_URL}/route?#{querystring}"
  end
end
