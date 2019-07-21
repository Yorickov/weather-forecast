class Printer
  def self.print_result(parser)
    puts
    puts 'Предоставлено Meteoservice.ru - https://www.meteoservice.ru'
    puts
    puts parser.city_name
    puts

    parser.forecast_nodes.each do |node|
      puts Forecast.create(node)
      puts
    end
  end
end
