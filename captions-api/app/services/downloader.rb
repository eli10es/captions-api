# frozen_string_literal: true

require "open-uri"

MAX_SIZE = 5 * 1024 * 1024

class Downloader
  def download(image_link)
    begin
      result = URI.open(image_link)
      if result.size > MAX_SIZE
        return nil
      end
      imageInfo = result.read
    rescue OpenURI::HTTPError
      return nil
    end
    image_name = "#{SecureRandom.uuid}.jpg"
    File.open("./tmp/images/#{image_name}", "wb") do |local_file|
      local_file.write(imageInfo)
    end
    image_name
  end
end
