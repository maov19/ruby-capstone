require_relative './helper_spec'

RSpec.describe MusicAlbum do
  before do
    @music_album = MusicAlbum.new('Sgt. Pepper\'s Lonely Hearts Club Band', '1967-06-01', on_spotify: true)
  end

  it 'is an instance of the MusicAlbum class' do
    expect(@music_album).to be_instance_of(MusicAlbum)
  end

  it 'has a name attribute' do
    expect(@music_album.name).to eq('Sgt. Pepper\'s Lonely Hearts Club Band')
  end

  it 'has a publish date attribute' do
    expect(@music_album.publish_date).to eq(Date.parse('1967-06-01'))
  end

  context 'when on_spotify is true' do
    it 'can be archived' do
      expect(@music_album.can_be_archived?).to be true
    end
  end

  context 'when on_spotify is false' do
    before do
      @music_album = MusicAlbum.new('Thriller', '1982-11-30', on_spotify: false)
    end

    it 'cannot be archived' do
      expect(@music_album.can_be_archived?).to be false
    end
  end
end
