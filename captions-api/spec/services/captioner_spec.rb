# frozen_string_literal: true

require './app/services/captioner'

RSpec.describe 'Captioner' do
  describe 'captioner' do
    let(:captioner) { Captioner.new }
    it 'adds text to an image' do
      result = captioner.caption('photo-1647549831144-09d4c521c1f1', 'random-text')
      expect(result).to eq('photo-1647549831144-09d4c521c1f1-modified.jpg')
    end
  end
end
