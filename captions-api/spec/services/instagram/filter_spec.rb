# frozen_string_literal: true

require './app/services/instagram/filter'
require 'securerandom'
require 'mini_magick'

RSpec.describe 'Filter' do
  describe 'blackwhite' do
    let(:filter) { Filter.new }
    let(:image_before) { "random.jpg" }

    before do
      image = MiniMagick::Image.open("./spec/fixtures/images/random.jpg")
      image.write("./tmp/images/#{image_before}")
    end

    after do
      File.delete("./tmp/images/#{image_before}") if File.exist?("./tmp/images/#{image_before}")
    end


    it 'applies blackwhite filter to the image' do
      image_before_filter = MiniMagick::Image.open("./tmp/images/#{image_before}")
      filter.filter(image_before, "blackwhite")
      image_after_filter = MiniMagick::Image.open("./tmp/images/#{image_before}")

      expect(image_before_filter.colorspace).not_to eq(image_after_filter.colorspace)
    end

    it 'applies light blur filter to the image' do
      image_before_filter = MiniMagick::Image.open("./tmp/images/#{image_before}")
      filter.filter(image_before, "light_blur")
      image_after_filter = MiniMagick::Image.open("./tmp/images/#{image_before}")
      expect(image_before_filter).not_to eq(image_after_filter)
    end

    it 'applies hard blur filter to the image' do
      image_before_filter = MiniMagick::Image.open("./tmp/images/#{image_before}")
      filter.filter(image_before, "hard_blur")
      image_after_filter = MiniMagick::Image.open("./tmp/images/#{image_before}")
      expect(image_before_filter).not_to eq(image_after_filter)
    end
  end
end
