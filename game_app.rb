require_relative 'game'
require_relative 'author'
require 'json'
require 'pry'

class GameApp
  def initialize
    @games_file = './data/games_authors.json'
    @games = []
    @authors = []
    load_data
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
    add_game(publish_date, multiplayer, last_played)
  end

  def list_authors
    if @authors.empty?
      puts 'No authors found'
    else
      puts 'Authors: '
      puts '...................................'
      @authors.each { |author| puts "Fullname: #{author.last_name} #{author.first_name} " }
      puts '...................................'
    end
  end

  def list_games
    puts 'No games found.' if @games.empty?
    puts '...................................'
    @games.each do |game|
      puts "Published on : #{game.publish_date}"
      puts "Last Played on : #{game.last_played_at}"
      puts "Multiplayer? : #{game.multiplayer}"
      puts '...................................'
    end
  end

  def create_game(sel, publish_date, multi, last_played)
    author_ind = sel - 1
    if author_ind >= 0 && author_ind < @authors.length
      author = @authors[author_ind]
      game = Game.new(publish_date, last_played, multi)
      game.add_author(author)
      @games << game
      puts 'Added game successfully'
    else
      puts 'Invalid author selection'
    end
  end

  def add_author(publish_date, multi, lastplayed)
    puts ''
    puts '.....................'
    puts 'Enter author details'
    puts '.....................'
    puts ''
    puts 'First Name: '
    firstname = gets.chomp
    puts 'Last Name: '
    lastname = gets.chomp
    author = Author.new(first_name: firstname, last_name: lastname)
    game = Game.new(publish_date, lastplayed, multi)

    existing_author = @authors.find { |a| a.first_name == author.first_name && a.last_name == author.last_name }
    if existing_author.nil?
      @games << game
      game.add_author(author)
      @authors << author
    else
      game.add_author(existing_author)
      @games << game
    end
    puts '=========================='
    puts 'Author added successfully'
  end

  def select_author_option(publish_date, multi, lastplayed)
    puts ''
    puts 'Press 1 to add new author for the game or Press 2 to select from list of authors'
    puts '=========================='
    author_option = gets.chomp.to_i
    if author_option == 1
      add_author(publish_date, multi, lastplayed)
    elsif author_option == 2
      display_authors
      puts ''
      puts 'Press the number to select the author.'
      sel_option = gets.chomp.to_i
      create_game(sel_option, publish_date, multi, lastplayed)
    else
      puts 'Invalid option selected, Try again'
      select_author_option
    end
  end

  def add_game(publish_date, multi, lastplayed)
    if @authors.empty?
      puts ''
      puts 'No authors found. Please add an author first.'
      add_author(publish_date, multi, lastplayed)
    else
      select_author_option(publish_date, multi, lastplayed)
    end
    save_data
  end

  def display_authors
    @authors.each_with_index do |author, index|
      puts "#{index + 1}. #{author.last_name} #{author.first_name}"
    end
  end

  def load_data
    if File.exist?(@games_file)
      data = JSON.parse(File.read(@games_file))
      data.map do |games_data|
        author = Author.new(first_name: games_data['author']['first_name'],
                            last_name: games_data['author']['last_name'])
        game = Game.new(games_data['publish_date'], games_data['last_played_at'], games_data['multiplayer'])
        @games << game
        game.add_author(author)
        @authors << author
      end
    else
      []
    end
  end

  def save_data
    games = @games.map do |game|
      {
        publish_date: game.publish_date,
        last_played_at: game.last_played_at,
        multiplayer: game.multiplayer,
        author: {
          first_name: game.author.first_name,
          last_name: game.author.last_name
        }
      }
    end
    File.write(@games_file, games.to_json)
  end
end
