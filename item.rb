class Item
  attr_accessor :publish_date, :archived

  def initialize(publish_date)
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    (Time.now.year - @publish_date.year) > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
