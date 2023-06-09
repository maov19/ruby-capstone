require_relative 'label'
require 'date'

class Item
  attr_reader :id, :publish_date, :genre, :label
  attr_accessor :archived, :author

  def initialize(publish_date, archived: false)
    @id = rand(1..1000)
    @publish_date = publish_date
    @archived = archived
    @label = nil
    @author = nil
  end

  def genre=(genre)
    @genre = genre
    genre.items << self unless genre.items.include?(self)
  end

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10
  end

  def add_author(author)
    @author = author
    author.add_item(self)
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
