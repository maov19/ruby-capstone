require_relative '../game'
require_relative '../author'
require_relative '../game_app'

RSpec.describe GameApp do
  let(:game_app) { GameApp.new }

  describe '#check_multiplayer' do
    it 'returns true if the user input is "Y"' do
      allow(game_app).to receive(:gets).and_return('Y')
      expect(game_app.check_multiplayer).to eq(true)
    end

    it 'returns false if the user input is "N"' do
      allow(game_app).to receive(:gets).and_return('N')
      expect(game_app.check_multiplayer).to eq(false)
    end
  end

  describe '#game_input' do
    before do
      allow(game_app).to receive(:gets).and_return('01/01/2023', '01/01/2023', 'Y')
    end
  end

  describe '#list_authors' do
    it 'displays the list of authors when authors are present' do
      author = Author.new(first_name: 'John', last_name: 'Doe')
      game_app.instance_variable_get(:@authors) << author
      expect { game_app.list_authors }.to output(/Authors:/).to_stdout
    end
  end

  describe '#list_games' do
    it 'displays the list of games when games are present' do
      game = Game.new('01/01/2023', '01/01/2023', true)
      game_app.instance_variable_get(:@games) << game
      expect { game_app.list_games }.to output(/Published on/).to_stdout
    end
  end

  # You can write more tests for other methods in the GameApp class

  describe '#load_data' do
    it 'loads data from the games file' do
      allow(File).to receive(:exist?).and_return(true)
      data = '[{"publish_date": "01/01/2023", "last_played_at": "01/01/2023", "multiplayer": true,
      "author": {"first_name": "J", "last_name": "D"}}]'
      allow(File).to receive(:read).and_return(data)
      expect { game_app.load_data }.to change { game_app.instance_variable_get(:@games).length }.by(1)
    end

    it 'returns an empty array if the games file does not exist' do
      allow(File).to receive(:exist?).and_return(false)
      expect(game_app.load_data).to eq([])
    end
  end
end
