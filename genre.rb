require_relative 'music_album'

class Genre
  attr_accessor :name, :items
  attr_reader :id

  def initialize(name, id: Random.new.rand(1..1000))
    @id = id
    @name = name
    @items = []
  end

  def add_item(item)
    @items.push(item)
    item.genre = self
  end
end
