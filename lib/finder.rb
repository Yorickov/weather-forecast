class Finder
  attr_reader :country_name, :city_name, :forecast_nodes

  DEFAULT_CITY = 'Украина,Киев'.freeze

  def initialize(params)
    @country_name, @city_name = params
    @forecast_nodes = ''
  end

  def self.create
    country_name, city_name = input_text.split(',')
    unless country_name != '' && city_name
      puts 'Both fields must be filled'
      return create
    end

    new([country_name, city_name])
  end

  def self.input_text
    word = STDIN.gets.encode('UTF-8').chomp
    word == '' ? DEFAULT_CITY : word
  end

  def find_country_id(html)
    doc = Nokogiri::HTML(html)
    country_id = nil
    doc.css('select#country_list option').each do |opt|
      country_id = opt['value'] if opt.content.encode('UTF-8') == @country_name
    end
    country_id
  end

  def find_city_id(json)
    cities = JSON.parse(json)
    return nil unless cities.include?(@city_name)

    cities[city_name]['point']
  end

  def get_nodes(xml)
    doc = REXML::Document.new(xml)
    doc.root.elements['REPORT/TOWN'].elements.to_a
  end

  # rubocop:disable Metrics/AbcSize
  def get_xml_data(service_link, country_link, city_link)
    res_html = Net::HTTP.get_response(URI.parse(service_link))
    country_id = find_country_id(res_html.body)
    return puts 'No such a country' unless country_id

    res_json = Net::HTTP.get_response(URI.parse("#{country_link}#{country_id}"))
    city_id = find_city_id(res_json.body)
    return puts 'No such a city' unless city_id

    res_xml = Net::HTTP.get_response(URI.parse("#{city_link}#{city_id}.xml"))
    @forecast_nodes = get_nodes(res_xml.body)
  end
  # rubocop:enable Metrics/AbcSize
end
