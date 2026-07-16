# frozen_string_literal: true

require './app/services/captioner'
require 'securerandom'

RSpec.describe 'Captioner' do
  describe 'captioner' do
    let(:captioner) { Captioner.new }
    it 'adds text to an image' do
      allow(SecureRandom).to receive(:uuid).and_return('random_uuid')
      result = captioner.caption('random_uuid', 'random-text')
      expect(result).to eq('random_uuid')
    end

    it 'creates same files with different names'  do
      allow(SecureRandom).to receive(:uuid).and_return('random_uuid')
      result1 = captioner.caption('random_uuid', 'random-text')
      allow(SecureRandom).to receive(:uuid).and_return('random_uuid2')
      result2 = captioner.caption('random_uuid2', 'random-text-2')
      expect(result1).not_to eq(result2)
    end
  end
end
