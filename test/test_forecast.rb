require 'minitest/autorun'
require 'forecast'

class TestForecast < Minitest::Test
  def setup
    @forecast = Forecast.new(
      date: Date.parse('17.07.2019'),
      time_of_day: 'вечер',
      temperature_min: 12,
      temperature_max: 18,
      cloudiness: 'clear',
      max_wind: 3,
      max_relwet: 77,
      max_pressure: 762
    )
  end

  def test_forecast
    expected = "17.07.2019, вечер\n" \
    "+12..+18, ветер 3 м/с, ясно\n" \
    'Влажность: 77%. Давление: 762 мм рт.ст'

    assert_equal(expected, @forecast.to_s)
  end
end
