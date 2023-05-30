require_relative 'item'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state, :label
  attr_writer :label

  def initialize(publish_date, publisher, cover_state, labels: [])
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state
    @labels = labels
  end

  def can_be_archived?
    super || @cover_state.downcase == 'bad'
  end

  def add_label
    @labels << label
  end
end
