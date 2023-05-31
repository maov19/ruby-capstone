require_relative 'item'
require_relative 'music_app'
require_relative 'game_app'
require 'Date'

class Main
  def initialize
    @music_app = MusicAlbumMethods.new
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
    when 2
      # List all labels
      puts 'Listing all labels...'
    when 3
      # Add a book
      puts 'Adding a book...'
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

  def check_multiplayer
    puts 'Is the game multiplayer [Y/N]: '
    val = gets.chomp.upcase
    case val
    when 'Y'
      true
    when 'N'
      false
    else
      puts 'Invalid selection, please type either Y or N to proceed'
      check_permission
    end
  end

  def game_input
    puts 'Publish Date e.g dd/mm/yyyy: '
    publish_date = gets.chomp.to_s
    puts 'Last played date e.g dd/mm/yyyy: '
    last_played = gets.chomp.to_s
    multiplayer = check_multiplayer
    @game_app.add_game(publish_date, multiplayer, last_played)
  end

  def game_selection(choice)
    case choice
    when 7
      @game_app.list_games
    when 8
      @game_app.list_authors
    when 9
      game_input
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
