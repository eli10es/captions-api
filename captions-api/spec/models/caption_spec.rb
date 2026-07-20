require 'rails_helper'

RSpec.describe Caption do
  subject {
    Caption.new(
      url: "some_url.com",
      text: "some_text",
      caption_url: "image_path"
    )
  }

  describe 'valid/invalid cases' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'text is missing' do
      subject.text = nil
      expect(subject).not_to be_valid
    end

    it 'url is missing' do
      subject.url = nil
      expect(subject).not_to be_valid
    end

    it 'text is not longer than 266 characters' do
      subject.text = "a"*270
      expect(subject).not_to be_valid
    end

    it 'caption_url is missing' do
      subject.caption_url = nil
      expect(subject).not_to be_valid
    end
  end
end
