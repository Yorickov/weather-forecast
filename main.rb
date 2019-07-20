require 'rubygems'
require 'bundler/setup'

require 'uri'
require 'net/http'
require 'json'
require 'nokogiri'
require 'rexml/document'

require './lib/metods.rb'
require './lib/forecast.rb'

puts 'Enter "Country,City"'

country_name, city_name = entry_request

res_html = Net::HTTP.get_response(
  URI.parse('https://www.meteoservice.ru/content/export')
)

country_id = find_country_id(res_html.body, country_name)
return puts 'No such a country' unless country_id

res_json = Net::HTTP.get_response(
  URI.parse("https://www.meteoservice.ru/location/cities?country_id=#{country_id}")
)

city_id = find_city_id(res_json.body, city_name)
return puts 'No such a city' unless city_id

res_xml = Net::HTTP.get_response(
  URI.parse("https://xml.meteoservice.ru/export/gismeteo/point/#{city_id}.xml")
)

doc = REXML::Document.new(res_xml.body)
forecast_nodes = doc.root.elements['REPORT/TOWN'].elements.to_a

puts
puts 'Предоставлено Meteoservice.ru - https://www.meteoservice.ru'
puts
puts city_name
puts

forecast_nodes.each do |node|
  puts Forecast.from_xml(node)
  puts
end
