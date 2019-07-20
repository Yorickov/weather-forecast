def input_text
  word = STDIN.gets.encode('UTF-8').chomp
  word == '' ? input_text : word
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
  cities[city_name]['point'] # if nil?
end
