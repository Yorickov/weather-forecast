class Printer
  def self.print_result(finder)
    puts
    puts 'Предоставлено Meteoservice.ru - https://www.meteoservice.ru'
    puts
    puts finder.city_name
    puts

    finder.forecast_nodes.each do |node|
      puts Forecast.from_xml(node)
      puts
    end
  end
end
