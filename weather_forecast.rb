require 'rubygems'
require 'bundler/setup'

require 'uri'
require 'net/http'
require 'json'
require 'nokogiri'
require 'rexml/document'

require './lib/forecast.rb'
require './lib/finder.rb'
require './lib/printer.rb'

puts 'Enter "Country,City"'

finder = Finder.create

service_link = 'https://www.meteoservice.ru/content/export'
country_link = 'https://www.meteoservice.ru/location/cities?country_id='
city_link = 'https://xml.meteoservice.ru/export/gismeteo/point/'

finder.get_xml_data(service_link, country_link, city_link)

Printer.print_result(finder)
