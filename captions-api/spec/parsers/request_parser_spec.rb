# frozen_string_literal: true

require './app/parsers/request_parser'

RSpec.describe 'RequestParser' do
  describe 'parse' do
    let(:request_parser) { RequestParser.new }

    it 'returns error for invalid data' do
      result = request_parser.parse_json("not a json")
      expect(result).to eq({
                             "code" => "invalid json",
                             "title" => "invalid json",
                             "description" => "The given json is not a Valid Json"
                           })
    end
  end
end
