require "debug" # TODO: remove

require "cgi"
require "digest"
require "json"
require "net/http"
require "nokogiri"
require "time"

require_relative "./api"
require_relative "./departure"
require_relative "./departures_parser"
