require 'minitest/autorun'
require 'metods'

require 'rubygems'
require 'bundler/setup'

require 'nokogiri'

class TestMethods < Minitest::Test
  def setup
    @html = '<div class="bordered">
    <select name="country_list" id="country_list" size="12" multiple="" class="font-smaller">
      <option value="40">Австралия</option>
      <option value="104">Ямайка</option>
      <option value="28">Япония</option>
      </select>
    </div>'
    @country_name = 'Япония'
  end

  def test_find_country_id
    assert_equal('28', find_country_id(@html, @country_name))
  end
end
