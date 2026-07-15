class Caption < ApplicationRecord
  validates :text, presence: true, length: {maximum: 266}
  validates :url, presence: true
  validates :caption_url, presence: true
end
