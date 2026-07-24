# frozen_string_literal: true

require "dry/validation"

class InstagramCaptionContract < Dry::Validation::Contract
  TYPES   = %w[image color gradient].freeze
  FILTERS = %w[blackwhite light_blur hard_blur].freeze
  params do
    required(:caption).hash do
      required(:type).filled(:string, included_in?: TYPES)
      required(:text).filled(:string)
      optional(:url).filled(:string)
      optional(:filter).filled(:string, included_in?: FILTERS)
      optional(:color).filled(:string)
      optional(:start_color).filled(:string)
      optional(:end_color).filled(:string)
    end
  end

  rule("caption.text") do
    key.failure("must be less than 266 characters") if value.length > 266
  end
end
