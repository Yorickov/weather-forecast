def input_text
  word = STDIN.gets.encode('UTF-8').chomp
  word == '' ? input_text : word
end

def entry_request
  country_name, city_name = input_text.split(',')
  unless country_name != '' && city_name
    puts 'Both fields must be filled'
    return entry_request
  end
  [country_name, city_name]
end

def find_country_id(html, country_name)
  doc = Nokogiri::HTML(html)
  country_id = nil
  doc.css('select#country_list option').each do |opt|
    country_id = opt['value'] if opt.content.encode('UTF-8') == country_name
  end
  country_id
end

def find_city_id(json, city_name)
  cities = JSON.parse(json)
  return nil unless cities.include?(city_name)

  cities[city_name]['point']
end
