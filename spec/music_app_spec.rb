require_relative './helper_spec'
require 'date'

RSpec.describe MusicAlbumMethods do
  before do
    @music_app = MusicAlbumMethods.new
  end

  it 'is an instance of the MusicAlbumMethods class' do
    expect(@music_app).to be_instance_of(MusicAlbumMethods)
  end

  describe '#add_album' do
    before do
      allow(@music_app).to receive(:gets).and_return(
        'Test Album',
        '2023-05-31',
        'Y',
        'rock'
      )
    end

    it 'adds the correct album to the albums list' do
      @music_app.add_album
      album = @music_app.albums.last
      expect(album.name).to eq('Test Album')
      expect(album.publish_date).to eq(Date.parse('2023-05-31'))
      expect(album.on_spotify).to eq(true)
      expect(album.genres).to eq('rock')
    end
  end
end
