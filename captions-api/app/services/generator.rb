# frozen_string_literal: true

class Generator
  def initialize(downloader, captioner)
    @downloader = downloader
    @captioner = captioner
  end

  def generate(text, image_link)
    image_name = @downloader.download(image_link)
    new_name = @captioner.caption(image_name, text)
    "http://localhost:3000/public/#{new_name}"
  end
end

