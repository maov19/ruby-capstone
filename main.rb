require_relative 'item'

class Main
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

  def select_choice(choice)
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
    when 4
      # List all music albums
      puts 'Listing all music albums...'
    when 5
      # List all genres
      puts 'Listing all genres...'
    when 6
      # Add a music album
      puts 'Adding a music album...'
    when 7
      # List all games
      puts 'Listing all games...'
    when 8
      # List all authors
      puts 'Listing all authors...'
    when 9
      # Add a game
      puts 'Adding a game...'
    end

    puts "\n"
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
