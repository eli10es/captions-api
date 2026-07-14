# frozen_string_literal: true

require 'mini_magick'
class Captioner
  def caption(image_name, text)
    File.open("./tmp/images/#{image_name}.jpg") do |image|
      image = MiniMagick::Image.open(image)
      image.combine_options do |c|
        c.gravity 'center'
        c.draw "text 0,200 '#{text}'"
        c.undercolor 'White'
        c.fill 'Black'
        c.font 'Helvetica'
        c.pointsize '60'
      end
      image.write("./public/#{image_name}-modified.jpg")
    end
    "#{image_name}-modified.jpg"
  end
end
