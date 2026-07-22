# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstagramCaption do
  subject {
    InstagramCaption.new(
      type: "image",
      url: "http://image.url",
      text: "caption text",
      filter: "blackwhite",
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

    it 'type is missing' do
      subject.type = nil
      expect(subject).not_to be_valid
    end
  end
end
