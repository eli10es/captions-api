# frozen_string_literal: true

require './app/services/instagram/background'

RSpec.describe 'Background' do
  describe 'background' do
    let(:background) { Background.new }

    after do
      File.delete("./tmp/images/#{@image_name}") if File.exist?("./tmp/images/#{@image_name}")
    end

    it "creates solid color background with correct size" do
      @image_name = background.solid("#FFFFFF")
      image = MiniMagick::Image.open("./tmp/images/#{@image_name}")
      expect(image.width).to eq(1080)
      expect(image.height).to eq(1440)
    end

    it "creates gradient background with correct size" do
      @image_name = background.gradient("#FFFFFF", "#000000")
      image = MiniMagick::Image.open("./tmp/images/#{@image_name}")
      expect(image.width).to eq(1080)
      expect(image.height).to eq(1440)
    end
  end
end
