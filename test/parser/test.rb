require 'csv'
require 'require_all'
require_rel '../../test/test_helper.rb'

class ParserTest < Minitest::Test
  def test_rss_parser
    reader = FileReader.new
    test_data = reader.read('test/fixtures/rssexample')

    parser = AtomParser.new
    parsed_data = parser.parse(test_data)

    assert parsed_data[:channel][:title] == 'Test Rest title'
  end
end