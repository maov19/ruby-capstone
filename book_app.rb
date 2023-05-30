require_relative 'book'
require_relative 'label'

class BookActions
  def initialize
    @books = []
  end

  def list_books
    if @books.empty?
      puts 'No books found!'
    else
      puts "\n"
      puts '--------------- Book Info ---------------'
      @books.each do |book|
        puts "Title: #{book.label&.title}"
        puts "Publisher: #{book.publisher}"
        puts "Cover State: #{book.cover_state}"
        puts "Publish Date: #{book.publish_date}"
        puts '------------------------------------------'
      end
    end
  end

  def list_labels
    labels = @books.map(&:label).uniq
    puts "\n"
    if labels.empty?
      puts "No labels found!\n"
    else
      puts '--------------- Label Info ---------------'
      labels.each do |label|
        puts "Color: #{label.color} - Title: #{label.title}\n"
        puts '------------------------------------------'
      end
    end
  end

  def add_book
    print 'Enter the book title: '
    title = gets.chomp

    print 'Enter the book publisher: '
    publisher = gets.chomp

    print 'Enter the cover state of the book: (G)ood or (B)ad?'
    cover_state = gets.chomp.downcase
    case cover_state
    when 'b'
      cover_state = 'bad'
    when 'g'
      cover_state = 'good'
    end

    print 'Enter the publish date of the book (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)

    print 'Enter the book label color: (R)ed-(G)reen-(B)lue?'
    color = gets.chomp.downcase
    case color
    when 'r'
      color = 'red'
    when 'g'
      color = 'green'
    when 'b'
      color = 'blue'
    end

    book = Book.new(publish_date, publisher, cover_state)
    label = Label.new(1, title, color)
    label.add_item(book)

    @books << book
    puts '------------------------------------------'
    puts "Book added successfully\n"
  end
end
