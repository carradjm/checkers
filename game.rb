require_relative 'board.rb'
require 'debugger'
require_relative 'CheckerErrors.rb'

class Game
include CheckerErrors

  attr_accessor :board, :player1, :player2


  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2

  end

  def play
    puts "Welcome to Checkers!"
    @board = Board.new
    until won?
      @board.display
      make_move(@player1)
      if won?
        return
      end
      @board.display
      make_move(@player2)
      if won?
        return
      end
    end
  end

  def make_move(player)
    begin
      check_available_jumps(player.color)
    rescue MustTakeJump
      puts "ALERT: Capture available."
    end

    begin
      puts "#{player.name}, pick a piece to move (e.g. 2,2)."

      start_pos = gets.chomp

      x_start = start_pos[0].to_i
      y_start = start_pos[2].to_i

      check_if_player_piece([x_start,y_start],player.color)
      check_if_available_move([x_start,y_start],player.color)
    rescue NotYoPieceError
      puts "Please choose one of your own pieces."
      retry
    rescue NoAvailableMoveError
      puts "That piece has no available moves.  Pick another."
      retry
    end

    begin
      puts "Where do you want to move? (e.g. 3,3)"
      end_pos = gets.chomp

      x_end = end_pos[0].to_i
      y_end = end_pos[2].to_i

      check_if_moveable_spot([x_start, y_start],[x_end, y_end])
    rescue CannotMoveThere
      puts "You can't move there. Pick another space."
      retry
    end

    @board[[x_start, y_start]].perform_moves([[x_end, y_end]])

  end

  def choose_move(player)

  end

  def won?
    if @board.grid.flatten.compact.none?{ |piece| piece.color == :white}
      puts "Black wins!"
      return true
    end

    if @board.grid.flatten.compact.none?{ |piece| piece.color == :black}
      puts "White wins!"
      return true
    end

    false
  end

end

class HumanPlayer

  attr_reader :color, :name

  def initialize(name, color)
    @name = name
    @color = color.to_sym
  end

end

p1 = HumanPlayer.new("Bob", "white")

p2 = HumanPlayer.new("Steve", "black")

game = Game.new(p1, p2)
# game.play
