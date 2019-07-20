require 'rubygems'
require 'bundler/setup'

require 'uri'
require 'net/http'
require 'json'
require 'nokogiri'

require './lib/metods.rb'

puts 'Enter "Country,City"'

country_name, city_name = input_text.split(',') # => fn

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

puts city_id
