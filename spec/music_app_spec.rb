require_relative './helper_spec'
require 'date'

RSpec.describe MusicAlbumMethods do
  before do
    @music_app = MusicAlbumMethods.new
  end

  it 'is an instance of the MusicAlbumMethods class' do
    expect(@music_app).to be_instance_of(MusicAlbumMethods)
  end

  it 'has a [] albums attribute' do
    expect(@music_app.albums).to eq([])
  end

  it 'albums length should be zero' do
    expect(@music_app.albums.length).to eq(0)
  end

  describe '#add_album' do
    before do
      allow(@music_app).to receive(:gets).and_return(
        'Test Album',
        '2023-05-31',
        'Y',
        'Rock'
      )
    end

    it 'adds a new album to the albums list' do
      expect { @music_app.add_album }.to change { @music_app.albums.length }.by(1)
    end

    it 'adds the correct album to the albums list' do
      @music_app.add_album
      album = @music_app.albums.first
      expect(album.name).to eq('Test Album')
      expect(album.publish_date).to eq(Date.parse('2023-05-31'))
      expect(album.on_spotify).to eq(true)
      expect(album.genres).to eq('Rock')
    end
  end
end
