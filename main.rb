require_relative 'item'
require_relative 'music_app'
require_relative 'book_app'
require_relative 'game_app'
require 'Date'

class Main
  def initialize
    @music_app = MusicApp.new
    @book_app = BookActions.new
    @game_app = GameApp.new
  end

  def display_options
    puts '1. List all books.'
    puts '2. List all labels (e.g. Gift, New).'
    puts '3. Add a book.'
    puts '4. List all music albums.'
    puts '5. List all genres (e.g Comedy, Thriller).'
    puts '6. Add a music album.'
    puts '7. List of games.'
    puts '8. List all authors (e.g. Stephen King).'
    puts '9. Add a game.'
    puts '10. Quit'
  end

  def book_selection(choice)
    case choice
    when 1
      # List all books
      puts 'Listing all books...'
      @book_app.list_books
    when 2
      # List all labels
      puts 'Listing all labels...'
      @book_app.list_labels
    when 3
      # Add a book
      puts 'Adding a book...'
      @book_app.add_book
    end
  end

  def music_selection(choice)
    case choice
    when 4
      # List all music albums
      puts 'Listing all music albums...'
      @music_app.list_all_albums
    when 5
      # List all genres
      puts 'Listing all genres...'
      @music_app.list_all_genres
    when 6
      # Add a music album
      puts 'Adding a music album...'
      @music_app.add_album
    end
  end

  def game_selection(choice)
    case choice
    when 7
      @game_app.list_games
    when 8
      @game_app.list_authors
    when 9
      @game_app.game_input
    end

    puts "\n"
  end

  def select_choice(choice)
    book_selection(choice)
    music_selection(choice)
    game_selection(choice)
  end
end

def main
  main = Main.new
  puts "\n"
  puts 'Catalog of My Things - Menu'

  loop do
    main.display_options
    choice = gets.chomp.to_i

    if choice == 10
      puts 'Exiting the Catalog of My Things app...'
      break
    elsif choice < 1 || choice > 10
      puts 'Invalid choice. Please select a valid option.'
      main.display_options
    else
      main.select_choice(choice)
    end
  end
end

main
