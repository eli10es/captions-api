# frozen_string_literal: true

require "./app/parsers/request_parser"

class CaptionRequestParser < RequestParser
  def parse(request_data)
    request_data = parse_json(request_data)
    errors =[]

    errors << "caption parameter is missing from the request body. It is a required parameter and the request cannot be processed without it" unless request_data.key?("caption")
    errors << "text parameter is missing from the request body. It is a required parameter and the request cannot be processed without it" unless request_data["caption"]&.key?("text")
    errors << "url parameter is missing from the request body. It is a required parameter and the request cannot be processed without it" unless request_data["caption"]&.key?("url")

    if !errors.empty?
      return {
        "errors" => errors.map { |error|  {
          "code" => "missing_parameters",
          "title" => "Parameter is missing from the request body",
          "description" => error
        }}
      }

    end

    request_data["caption"]
  end
end
