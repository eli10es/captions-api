require './app/services/generator'

RSpec.describe 'Generator' do
  let(:downloader) { instance_double('Downloader') }
  let(:captioner) { instance_double('Captioner') }
  let(:generator) { Generator.new(downloader, captioner) }
  describe 'generate' do
    it 'returns a working url' do
      allow(downloader).to receive(:download).with('url').and_return('img')
      allow(captioner).to receive(:caption).with('img', 'text').and_return('img-modified.jpg')
      expect(generator.generate('text', 'url')).to eq('http://localhost:3000/public/img-modified.jpg')
    end
  end
end
