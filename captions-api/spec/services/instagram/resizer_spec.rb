
# frozen_string_literal: true

require './app/services/instagram/resizer'
require 'securerandom'
require 'mini_magick'

RSpec.describe 'Resizer' do
  describe 'resize' do
    let(:resizer) { Resizer.new }
    let(:image_name) { "random.jpg" }
    before do
      MiniMagick.convert do |convert|
        convert.size "677x699"
        convert << "xc:#003166"
        convert << "./tmp/images/#{image_name}"
      end
    end

    after { File.delete("./tmp/images/#{image_name}") if File.exist?("./tmp/images/#{image_name}") }


    it "resizes image to exactly 1080x1440" do
      resizer.resize(image_name)
      image = MiniMagick::Image.open("./tmp/images/#{image_name}")
      expect(image.width).to eq(1080)
      expect(image.height).to eq(1440)
    end
  end
end
