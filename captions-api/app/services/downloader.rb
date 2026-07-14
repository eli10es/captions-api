# frozen_string_literal: true

require 'open-uri'

class Downloader
  def download(image_link)
    result = URI.open(image_link)
    imageInfo = result.read
    File.open("./tmp/images/#{result.base_uri.path.split('/').last}.jpg", 'wb') do |local_file|
      local_file.write(imageInfo)
    end
    result.base_uri.path.split('/').last
  end
end

