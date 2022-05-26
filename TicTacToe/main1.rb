# frozen_string_literal: true

class Board
  attr_reader :array

  def initialize
    @array = Array(1..9)
    @occupied_indexes = Array.new
  end 

  def check_winner(player)
    # check horizontal wins
    player.count = 0
    0.step(6, 3) do |i|
      i.upto(i + 2) do |j|
        player.count += 1 if @array[j] == player.marker
      end
    end
    if player.count == 3
      return true
    end 

    player.count = 0
    # check vertical wins
    0.upto(2) do |i|
      i.step(i+6, 3) do |j|
        player.count += 1 if @array[j] == player.marker
      end
    end
    if player.count == 3
      return true
    end

    # don't forget horizontal ones here 
    if (@array[0] == player.marker &&  @array[4] == player.marker && @array[4] == player.marker)
      return true
    end 

    if (@array[2] == player.marker &&  @array[4] == player.marker && @array[6] == player.marker)
      return true
    end 
    
    return false
  end

  def print_array
    0.step(6,3) do |i|
      i.step(i+2, 1) do |j|
        print "| #{@array[j]} "
      end
        print "| \n"
    end
  end
end

class Player
  attr_reader :marker, :name
  attr_accessor :count

  def initialize(name, marker)
    @name = name
    @marker = marker
    @count = 0
  end

  def win
    puts "GAME OVER! #{@name} is the winner!"
  end

  def mark_array
    puts "#{@name}, please enter a number (0-9) that is available to place an '#{@marker}'"
    index = gets.chomp
    while (index.length != 1) || !index.match?(/[[:digit:]]/ || index > 9 || index < 0)
      puts 'Sorry, that is an invalid answer. Please, try again.'
      index = gets.chomp
    end
    index
  end
end

class Game 
  
  attr_reader :board
  def initialize
    @player1 = Player.new(get_name(1), get_marker)
    @player2 = Player.new(get_name(2), get_marker(@player1.marker))
    @board = Board.new
  end

  def get_marker(other_marker = 'q')
    puts 'What 1 letter (or special character) would you like to be your game marker?'
    marker = gets.chomp
    while (marker.length != 1) || marker.match?(/[[:digit:]]/) || (marker == other_marker)
      error_message
      marker = gets.chomp
    end

    marker
  end

  def error_message
    puts 'Sorry, that is an invalid answer. Please, try again.'
  end

  def get_name(i)
    puts "What is the name of player #{i}?"
    gets.chomp
  end

  def play
    @board.print_array
    9.times do
      @board.array[@player1.mark_array.to_i - 1] = @player1.marker
      if @board.check_winner(@player1)
        @player1.win
        break
      end

      @board.array[@player2.mark_array.to_i - 1] = @player2.marker
      if @board.check_winner(@player2)
        @player2.win
        break
      end
      @board.print_array
      
    end
  end
end

# board = Board.new 
# board.print_array
# 0.upto(6) do |i|
#   puts i
# end 

game = Game.new
game.play