# frozen_string_literal: true

require "mini_magick"

class Filter
  def filter(image_name, filter)
    image = MiniMagick::Image.open("./tmp/images/#{image_name}")

    if filter == "blackwhite"
      image.colorspace "Gray"
    end

    if filter == "light_blur"
      image.blur "0x3"
    end

    if filter == "hard_blur"
      image.blur "0x8"
    end

    image.write("./tmp/images/#{image_name}")
    image_name
  end
end
