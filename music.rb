require_relative 'item'
require 'date'

class MusicAlbum < Item
  attr_accessor :name, :genres, :publish_date, :on_spotify
  attr_writer :genre

  def initialize(name, publish_date, on_spotify: false, genres: [])
    super(publish_date)
    @name = name
    @publish_date = Date.parse(publish_date)
    @on_spotify = on_spotify
    @genres = genres
  end

  def can_be_archived?
    super()
    (Date.today.year - @publish_date.year) > 10 && @on_spotify
  end

  def add_genre(genre)
    @genres << genre
  end
end
