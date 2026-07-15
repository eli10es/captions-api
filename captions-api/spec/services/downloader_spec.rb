# frozen_string_literal: true

require './app/services/downloader'

RSpec.describe 'Downloader' do
  describe 'download' do
    let(:downloader) { Downloader.new }
    it 'downloads an image' do
      allow(SecureRandom).to receive(:uuid).and_return('random_uuid')
      result = downloader.download('https://images.unsplash.com/photo-1647549831144-09d4c521c1f1')
      expect(result).to eq('random_uuid.jpg')
    end
  end
end
