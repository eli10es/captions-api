# frozen_string_literal: true

require './app/services/captioner'
require 'securerandom'

RSpec.describe 'Captioner' do
  describe 'captioner' do
    let(:captioner) { Captioner.new }
    it 'adds text to an image' do
      result = captioner.caption('random_uuid.jpg', 'random-text')
      expect(result).to eq('random_uuid.jpg')
    end

    it 'creates same files with different names'  do
      result1 = captioner.caption('random_uuid.jpg', 'random-text')
      result2 = captioner.caption('random_uuid2.jpg', 'random-text-2')
      expect(result1).not_to eq(result2)
    end
  end
end
