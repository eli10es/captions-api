# frozen_string_literal: true

class InstagramCaption < ApplicationRecord
  validates :text, presence: true, length: { maximum: 266 }
  validates :url, presence: true
  validates :type, presence: true
end