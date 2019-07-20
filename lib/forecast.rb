require 'date'

class Forecast
  TIME_OF_DAY = %w[ночь утро день вечер].freeze
  CLOUDINESS = %w[ясно малооблачно облачно пасмурно].freeze

  def initialize(params)
    @date = params[:date]
    @time_of_day = params[:time_of_day]
    @temperature_min = params[:temperature_min]
    @temperature_max = params[:temperature_max]
    @cloudiness = params[:cloudiness]
    @max_wind = params[:max_wind]
    @max_relwet = params[:max_relwet]
    @max_pressure = params[:max_pressure]
  end

  # rubocop:disable Metrics/AbcSize
  def self.from_xml(node)
    day = node.attributes['day']
    month = node.attributes['month']
    year = node.attributes['year']

    new(
      date: Date.parse("#{day}.#{month}.#{year}"),
      time_of_day: TIME_OF_DAY[node.attributes['tod'].to_i],
      temperature_min: node.elements['TEMPERATURE'].attributes['min'].to_i,
      temperature_max: node.elements['TEMPERATURE'].attributes['max'].to_i,
      cloudiness: node.elements['PHENOMENA'].attributes['cloudiness'].to_i,
      max_wind: node.elements['WIND'].attributes['max'].to_i,
      max_relwet: node.elements['RELWET'].attributes['max'].to_i,
      max_pressure: node.elements['PRESSURE'].attributes['max'].to_i
    )
  end
  # rubocop:enable Metrics/AbcSize

  def to_s
    "#{@date.strftime('%d.%m.%Y')}, #{@time_of_day}\n" \
    "#{temperature_range_string}, ветер #{@max_wind} м/с, " \
    "#{CLOUDINESS[@cloudiness.to_i]}\n" \
    "Влажность: #{@max_relwet}%. Давление: #{@max_pressure} мм рт.ст"
  end

  def temperature_range_string
    output = ''
    output << '+' if @temperature_min.positive?
    output << "#{@temperature_min}.."
    output << '+' if @temperature_max.positive?
    output << @temperature_max.to_s
    output
  end
end
