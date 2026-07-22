# frozen_string_literal: true

require "open-uri"

class Downloader
  MAX_SIZE = 5 * 1024 * 1024
  ALLOWED_MIME_TYPES = %w[image/jpg image/jpeg image/png].freeze

  class DownloadError < StandardError; end

  def download(image_link)
    result = fetch(image_link)

    raise DownloadError, "image is larger than 5 MB" if result.size > MAX_SIZE

    content_type = result.content_type
    unless ALLOWED_MIME_TYPES.include?(content_type)
      raise DownloadError, "unsupported image type: #{content_type}"
    end
    image_name = "#{SecureRandom.uuid}.jpg"
    File.open("./tmp/images/#{image_name}", "wb") do |local_file|
      local_file.write(result.read)
    end
    image_name
  end


  private

  def fetch(image_link)
    URI.open(image_link)
  rescue OpenURI::HTTPError, SocketError, Errno::ENOENT, URI::InvalidURIError => e
    raise DownloadError, "could not fetch image: #{e.message}"
  end
end
