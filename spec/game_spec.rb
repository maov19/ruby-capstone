require 'rspec'
require_relative '../game_app'

RSpec.describe Game do
  let(:game) { Game.new('12/02/2019', '10/03/2020', true) }

  it 'is an instance of the Game class' do
    expect(game).to be_instance_of(Game)
  end

  it 'has a publish_date attribute' do
    expect(game.publish_date).to eq('12/02/2019')
  end

  it 'has a last_played attribute' do
    expect(game.last_played_at).to eq('10/03/2020')
  end

  it 'has a multiplayer attribute' do
    expect(game.multiplayer).to eq(true)
  end
end
