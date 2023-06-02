require_relative 'item'
require 'date'

class MusicAlbum < Item
  attr_accessor :name, :genre, :publish_date, :on_spotify

  def initialize(name, publish_date, genre, on_spotify: false)
    super(publish_date)
    @name = name
    @publish_date = Date.parse(publish_date)
    @on_spotify = on_spotify
    @genre = genre
  end

  def can_be_archived?
    super()
    (Date.today.year - @publish_date.year) > 10 && @on_spotify
  end
end
