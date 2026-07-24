require 'rails_helper'

RSpec.describe InstagramCaption, type: :model do
  describe 'validations' do
    let(:normal_caption) { InstagramCaption.new(text: 'random_text', type: 'image', url: 'https://example.com/image.jpg') }
    let(:color_caption) { InstagramCaption.new(text: 'random_text', type: 'color', color: '#FFFFFF') }
    let(:gradient_caption) { InstagramCaption.new(text: 'random_text', type: 'gradient', start_color: '#FFFFFF', end_color: '#000000') }

    it 'returns valid for normal caption' do
      expect(normal_caption).to be_valid
    end

    it 'returns valid for color caption' do
      expect(color_caption).to be_valid
    end

    it 'returns valid for gradient caption' do
      expect(gradient_caption).to be_valid
    end

    it 'returns invalid for missing text' do
      normal_caption.text = nil
      expect(normal_caption).not_to be_valid
    end

    it 'returns invalid for missing type' do
      normal_caption.type = nil
      expect(normal_caption).not_to be_valid
    end

    it 'returns invalid for missing url when type is image' do
      normal_caption.url = nil
      expect(normal_caption).not_to be_valid
    end

    it 'returns invalid for missing color when type is color' do
      color_caption.color = nil
      expect(color_caption).not_to be_valid
    end

    it 'returns invalid for missing start_color or end_color when type is gradient' do
      gradient_caption.start_color = nil
      expect(gradient_caption).not_to be_valid

      gradient_caption.start_color = '#FFFFFF'
      gradient_caption.end_color = nil
      expect(gradient_caption).not_to be_valid
    end

    it 'returns invalid for text longer than 266 characters' do
      normal_caption.text = 'a' * 267
      expect(normal_caption).not_to be_valid
    end

    it 'returns invalid for type not in TYPES' do
      normal_caption.type = 'random_type'
      expect(normal_caption).not_to be_valid
    end
  end
end
