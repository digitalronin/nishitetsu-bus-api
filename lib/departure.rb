class Departure
  attr_reader :node

  def initialize(node)  # node is a nokogiri node
    @node = node
  end

  def route_number
    node.css("li.num").text  # e.g. 23
  end

  def route_type
    node.css("ul.label").css("li").first.text  # 都市高 / 普通
  end

  def minutes_late
    late_notice = node.css("div.notice p span").text
    if late_notice.match(/(\d+)/)
      $1.to_i
    else
      0
    end
  end

  def route_details
    node.css("h3.station span").text
  end

  def destination
    node.css("h3.station").text.sub(@route_details, "")
  end

  def expected_departure
    Time.parse(scheduled_departure) + (minutes_late * 60)
  end

  def scheduled_departure
    node.css("div.route p.time span").first.text
  end

  def scheduled_arrival
    node.css("div.route p.time span").last.text
  end

  def expected_in
    ((Time.now - expected_departure) / 60).to_i
  end

  def expected_arrival
    Time.parse(scheduled_arrival) + (minutes_late * 60)
  end
end
