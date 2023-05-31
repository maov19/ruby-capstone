require_relative 'music'
require 'json'

class MusicAlbumMethods
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
        puts "Album title: #{album.name}\n Released year: #{album.publish_date.year}\n Music genre: #{album.genres}\n"
        puts "___________________________\n"
      end
    end
  end

  def list_all_genres
    genres = @albums.map(&:genres).flatten.uniq
    if genres.empty?
      puts 'No genres found!'
    else
      puts "************************************************\nAll Genres\n"
      genres.each do |genre|
        puts "#{genre}\n"
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
    genres = gets.chomp
    album = MusicAlbum.new(name, publish_date, on_spotify: on_spotify, genres: genres)
    @albums << album
    puts "Album  '#{album.name}' has been added."
    save_data
  end

  def load_data
    if File.exist?(@filename)
      data = JSON.parse(File.read(@filename))
      data.map do |album_data|
        MusicAlbum.new(album_data['name'], album_data['publish_date'], on_spotify: album_data['on_spotify'],
                                                                       genres: album_data['genres'])
      end
    else
      []
    end
  end

  def save_data
    albums_json = @albums.map do |album|
      {
        name: album.name,
        publish_date: album.publish_date.iso8601,
        on_spotify: album.on_spotify,
        genres: album.genres
      }
    end

    File.write(@filename, albums_json.to_json)
  end
end
