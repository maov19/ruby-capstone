require_relative './helper_spec'

RSpec.describe Genre do
  before :each do
    @genre = Genre.new('Rock')
    @music_album = MusicAlbum.new('Sgt. Pepper\'s Lonely Hearts Club Band', '1967-06-01', on_spotify: true)
  end

  it 'is an instance of the Genre class' do
    expect(@genre).to be_instance_of(Genre)
  end

  it 'has a name attribute' do
    expect(@genre.name).to eq('Rock')
  end

  it 'has an empty items collection' do
    expect(@genre.items).to eq([])
  end

  it 'can add an item to its collection' do
    @genre.add_item(@music_album)
    expect(@genre.items).to include(@music_album)
  end

  it 'adds itself as the item\'s genre' do
    @genre.add_item(@music_album)
    expect(@music_album.genre).to eq(@genre)
  end

  it 'adds the item to its items collection' do
    @genre.add_item(@music_album)
    expect(@genre.items).to include(@music_album)
  end

  it 'adds itself to the item\'s genres collection' do
    @genre.add_item(@music_album)
    expect(@music_album.genres).to include(@genre)
  end
end
