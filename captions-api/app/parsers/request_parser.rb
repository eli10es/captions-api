# frozen_string_literal: true

require "json"

class RequestParser
  def parse_json(request_data)
    JSON.parse(request_data)
  rescue JSON::ParserError
    {
      "code" => "invalid json",
      "title" => "invalid json",
      "description" => "The given json is not a Valid Json"
    }
  end

  def parse(request_data)
    raise NotImplementedError, "#{self.class} must implement the 'parse' method."
  end
end
