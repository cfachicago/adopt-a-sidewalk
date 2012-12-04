# See README "Google Maps KML Endpoint"

unless ENV["GMAPS_KML_ENDPOINT"]
  abort "Missing GMAPS_KML_ENDPOINT environment variable: #{__FILE__}:#{__LINE__}"
end