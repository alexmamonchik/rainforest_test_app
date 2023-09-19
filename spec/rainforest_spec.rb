# frozen_string_literal: true

require 'rainforest'

RSpec.describe 'RainforestSpec' do
  context 'when has errors' do
    subject { Rainforest.new('https://letsrevolutionizetesting.com/challenge', :html) }

    it 'recommends to use json' do
      expect(subject.challenge).to eq('<h1>You should try JSON</h1>')
    end
  end

  context 'when successfully finished' do
    subject { Rainforest.new('https://letsrevolutionizetesting.com/challenge') }

    it 'congratulates with message' do
      expect(subject.challenge).to match('Congratulations')
    end
  end
end
