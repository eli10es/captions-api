class InstagramCaption < ApplicationRecord
  TYPES   = %w[image color gradient].freeze
  FILTERS = %w[blackwhite light_blur hard_blur].freeze

  self.inheritance_column = :_type_disabled

  validates :text, presence: true, length: { maximum: 266 }
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :url,         presence: true, if: -> { type == "image" }
  validates :color,       presence: true, if: -> { type == "color" }
  validates :start_color, presence: true, if: -> { type == "gradient" }
  validates :end_color,   presence: true, if: -> { type == "gradient" }
end
