# frozen_string_literal: true

class Board
  attr_reader :array

  def initialize
    @array = Array(1..9)
  end

  def check_winner
    # check horizontal wins
    if check_case(0, 1, 2) || check_case(3, 4, 5) || check_case(6, 7, 8) ||
    check_case(0, 3, 6) || check_case(1, 4, 7) || check_case(2, 5, 8) ||
    check_case(0, 4, 8) || check_case(2, 4, 6)
      return true
    end

    false
  end

  def print_array
    0.step(6, 3) do |i|
      i.step(i + 2, 1) do |j|
        print "| #{@array[j]} "
      end
      print "| \n"
    end
  end

  private

  def check_case(index1, index2, index3)
    if @array[index1] == @array[index2] && @array[index2] == @array[index3]
      true
    else
      false
    end
  end
end

class Player
  attr_reader :marker, :name

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def win
    puts "GAME OVER! #{@name} is the winner!"
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

  def play
    @board.print_array
    9.times do
      @board.array[mark_array(@player1).to_i - 1] = @player1.marker
      if @board.check_winner
        @player1.win
        break
      end
      @board.print_array

      @board.array[mark_array(@player2).to_i - 1] = @player2.marker
      if @board.check_winner
        @player2.win
        break
      end
      @board.print_array
    end
  end

  def mark_array(player)
    puts "#{player.name}, please enter a number (0-9) that is available to place an '#{player.marker}'"
    index = gets.chomp
    while !@board.array.include?(index.to_i)
      error_message
      index = gets.chomp
    end
    index
  end

  def error_message
    puts 'Sorry, that is an invalid answer. Please, try again.'
  end

  def get_name(i)
    puts "What is the name of player #{i}?"
    gets.chomp
  end
end

status = true

while status
  game = Game.new
  game.play
  puts "Would you like to play a new game? Press 'y' for yes or 'n' for no."
  answer = gets.chomp
  status = false if answer.downcase! != 'y'
end