require_relative 'book'
require_relative 'label'

class BookActions
  attr_accessor :books

  def initialize(file: './data/books.json')
    @file = file
    @books = load_books || []
  end

  def list_books
    if @books.empty?
      puts 'No books found!'
    else
      puts "\n"
      puts '--------------- Book Info ---------------'
      @books.each do |book|
        puts "Title: #{book.title}"
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
        name = label.is_a?(Label) ? label.name : label['name']
        color = label.is_a?(Label) ? label.color : label['color']

        puts "Color: #{color} - Name: #{name}\n"
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

    print 'Enter label name (e.g: buy, gift, found): '
    name = gets.chomp.downcase

    print 'Enter the book label color: '
    color = gets.chomp.downcase

    book = Book.new(title, publish_date, publisher, cover_state)
    label = Label.new(1, name, color)
    book.label = label

    @books << book
    puts '------------------------------------------'
    puts "Book added successfully\n"
    save_books
  end

  def load_books
    if File.exist?(@file)
      data = JSON.parse(File.read(@file))
      data.map do |book|
        Book.new(book['title'], book['publish_date'], book['publisher'], book['cover_state'], label: book['label'])
      end
    else
      []
    end
  end

  def save_books
    books_json = @books.map do |book|
      label_data = book.label.is_a?(Label) ? { name: book.label.name, color: book.label.color } : book.label
      {
        title: book.title,
        publish_date: book.publish_date,
        publisher: book.publisher,
        cover_state: book.cover_state,
        label: label_data
      }
    end

    File.write(@file, books_json.to_json)
  end
end
