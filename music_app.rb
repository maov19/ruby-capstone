require_relative 'music_album'
require_relative 'genre'
require 'json'

class MusicApp
  attr_accessor :albums

  def initialize(filename: './data/albums.json')
    @filename = filename
    @albums = load_data || []
  end

  def display_menu
    puts "Welcome to Music App! \nChoose an option:"
    puts '1. List all albums'
    puts '2. List all genres'
    puts '3. Add an album'
    puts '4. Quit'
  end

  def list_all_albums
    if @albums.empty?
      puts 'No albums found!'
    else
      puts '--------------- Album Information ---------------'
      @albums.each do |album|
        puts "Album title: #{album.name}\nReleased year: #{album.publish_date.year}\nGenre: #{album.genre.name}\n"
        puts "___________________________\n"
      end
    end
  end

  def list_all_genres
    genres = @albums.map(&:genre).uniq
    if genres.empty?
      puts 'No genres found!'
    else
      puts "************************************************\nAll Genres\n"
      genres.each do |genre|
        puts "#{genre.name}\n"
      end
      puts "===========================================================\n"
    end
  end

  def add_album
    puts 'Enter album title:'
    name = gets.chomp
    puts 'Enter date of release (YYYY-MM-DD):'
    publish_date = gets.chomp
    puts 'Is it on spotify? (Y/N):'
    on_spotify = gets.chomp.downcase == 'y'
    puts 'Enter the genre of the music album:'
    genre_input = gets.chomp.downcase

    genre = Genre.new(genre_input)
    album = MusicAlbum.new(name, publish_date, genre, on_spotify: on_spotify)
    genre.add_item(album)

    @albums << album
    puts "Album  '#{album.name}' has been added."
    save_data
  end

  def load_data
    if File.exist?(@filename)
      data = JSON.parse(File.read(@filename))
      data.map do |album_data|
        genre = Genre.new(album_data['genre']['name'], id: album_data['genre']['id'])

        MusicAlbum.new(album_data['name'], album_data['publish_date'], genre, on_spotify: album_data['on_spotify'])
      end
    else
      []
    end
  end

  def save_data
    albums_json = @albums.map do |album|
      genre_data = album.genre.is_a?(Genre) ? { id: album.genre.id, name: album.genre.name } : album.genre
      {
        name: album.name,
        publish_date: album.publish_date.iso8601,
        on_spotify: album.on_spotify,
        genre: genre_data
      }
    end

    File.write(@filename, albums_json.to_json)
  end
end
