require "mini_magick"

class Resizer
  SIZE = "1080x1440"

  def resize(image_name)
    image = MiniMagick::Image.open("./tmp/images/#{image_name}")

    image.combine_options do |c|
      c.resize "#{SIZE}^"
      c.gravity "center"
      c.extent SIZE
    end

    image.write("./tmp/images/#{image_name}")
    image_name
  end
end
