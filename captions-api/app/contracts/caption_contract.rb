# frozen_string_literal: true

require "dry/validation"

class CaptionContract < Dry::Validation::Contract
  params do
    required(:caption).hash do
      required(:url).filled(:string)
      required(:text).filled(:string)
    end
  end

  rule("caption.text") do
    key.failure("must be less than 266 characters") if value.length > 266
  end
end
