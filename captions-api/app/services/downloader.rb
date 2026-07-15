# frozen_string_literal: true

require 'open-uri'

class Downloader
  def download(image_link)
    result = URI.open(image_link)
    imageInfo = result.read
    image_name = "#{SecureRandom.uuid}.jpg"
    File.open("./tmp/images/#{image_name}", 'wb') do |local_file|
      local_file.write(imageInfo)
    end
    image_name
  end
end

