require "mini_magick"
require "securerandom"

class Background
  SIZE = "1080x1440"
  def solid(color)
    generate("xc:#{color}")
  end

  def gradient(start_color, end_color)
    generate("gradient:#{start_color}-#{end_color}")
  end

  private

  def generate(source)
    image_name = "#{SecureRandom.uuid}.jpg"

    MiniMagick.convert do |convert|
      convert.size SIZE
      convert << source
      convert << "./tmp/images/#{image_name}"
    end
    image_name
  end
end
