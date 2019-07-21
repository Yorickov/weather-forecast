require 'minitest/autorun'
require 'nokogiri'
require 'parser'

class TestFinder < Minitest::Test
  def setup
    @html = '<div class="bordered">
    <select name="country_list" id="country_list" size="12" multiple="" class="font-smaller">
      <option value="40">Австралия</option>
      <option value="104">Ямайка</option>
      <option value="28">Япония</option>
      </select>
    </div>'
    @parser = Parser.new(%w[Япония Токио])
  end

  def test_find_country_id
    assert_equal('28', @parser.find_country_id(@html))
  end
end
