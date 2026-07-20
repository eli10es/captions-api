# frozen_string_literal: true

require './app/parsers/caption_request_parser'

RSpec.describe 'CaptionRequestParser' do
  describe 'parse' do
    let(:request_parser) { CaptionRequestParser.new }

    it 'returns parsed caption data' do
      result = request_parser.parse('{"caption":{"url": "https://example.com", "text": "hello"}}')
      expect(result).to eq({
                             "url" => "https://example.com",
                             "text" => "hello"
                           })
    end

    it 'returns missing url error' do
      result = request_parser.parse('{"caption":{"text": "hello"}}')
      expect(result).to eq("errors" =>[ {
                             "code"=> "missing_parameters",
                             "title"=> "Parameter is missing from the request body",
                             "description"=> "url parameter is missing from the request body. It is a required parameter and the request cannot be processed without it"
                           } ])
    end

    it 'returns missing text error' do
      result = request_parser.parse('{"caption":{"url": "https://example.com"}}')
      expect(result).to eq("errors" => [ {
                              "code"=> "missing_parameters",
                              "title"=> "Parameter is missing from the request body",
                              "description"=> "text parameter is missing from the request body. It is a required parameter and the request cannot be processed without it"
                            } ])
    end

    it 'returns missing url error' do
      result = request_parser.parse('{"caption":{}}')
      expect(result).to eq("errors" => [ {
                              "code"=> "missing_parameters",
                              "title"=> "Parameter is missing from the request body",
                              "description"=> "text parameter is missing from the request body. It is a required parameter and the request cannot be processed without it"
                            }, {
                              "code"=> "missing_parameters",
                              "title"=> "Parameter is missing from the request body",
                              "description"=> "url parameter is missing from the request body. It is a required parameter and the request cannot be processed without it"
                            } ])
    end
  end
end
