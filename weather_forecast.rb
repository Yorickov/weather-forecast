require 'rubygems'
require 'bundler/setup'

require 'uri'
require 'net/http'
require 'json'
require 'nokogiri'
require 'rexml/document'

require_relative 'lib/forecast.rb'
require_relative 'lib/parser.rb'
require_relative 'lib/printer.rb'

puts 'Enter in format: "Country,City"'

parser = Parser.create

service_link = 'https://www.meteoservice.ru/content/export'
country_link = 'https://www.meteoservice.ru/location/cities?country_id='
city_link = 'https://xml.meteoservice.ru/export/gismeteo/point/'

parser.process_xml(service_link, country_link, city_link)

Printer.print_result(parser)
