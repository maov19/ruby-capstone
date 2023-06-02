require 'date'
require_relative '../item'
require_relative '../game'

RSpec.describe Game do
  let(:publish_date) { Date.new(2010, 1, 1) }
  let(:last_played_at) { Date.today.prev_year(1).strftime('%d/%m/%Y') }
  let(:game) { Game.new(publish_date, last_played_at, 'true', 'false') }

  describe '#initialize' do
    it 'sets the publish_date' do
      expect(game.publish_date).to eq(publish_date)
    end

    it 'sets the last_played_at' do
      expect(game.last_played_at).to eq(last_played_at)
    end

    it 'sets the multiplayer' do
      expect(game.multiplayer).to eq('true')
    end

    it 'sets the archived' do
      expect(game.archived).to eq('false')
    end
  end

  describe '#can_be_archived?' do
    it 'returns false if the game is not older than 2 years' do
      future_date = (Date.today + 1).strftime('%d/%m/%Y')
      game = Game.new(publish_date, future_date, 'true', 'false')
      expect(game.can_be_archived?).to be false
    end

    it 'returns false if the game cannot be archived' do
      game = Game.new(publish_date, last_played_at, 'true', 'true')
      expect(game.can_be_archived?).to be false
    end
  end
end
