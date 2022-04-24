class Api
  API_URL = "http://busnavi01.nishitetsu.ne.jp"

  def initialize()
    # TODO
  end

  # Returns HTML
  def live_departures(from:, to:)
    Net::HTTP.get(URI(departures_url(from: from, to: to)))
  end

  private

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
