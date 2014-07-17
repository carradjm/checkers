require_relative 'board.rb'
require 'debugger'

class Game

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
    #begin
      puts "Pick a piece to move (e.g. 2,2)."

      start_pos = gets.chomp

      x_start = start_pos[0].to_i
      y_start = start_pos[2].to_i

      # check_if_player_piece([x_start,y_start],self.color)
 #      check_if_available_move([x_start,y_start],self.color)
 #    rescue NotYoPieceError
 #      puts "Please choose one of your own pieces."
 #      retry
 #    rescue NoAvailableMoveError
 #      puts "That piece has no available moves.  Pick another."
 #      retry
 #    end

    # begin
#       check_available_jumps
#     rescue MustTakeJump
#       puts "ALERT: Capture available."
#     end
    #if jump available, keep getting input and adding to move_sequence
    #until jump no longer available

    # move_sequence = []

    puts "Where do you want to move? (e.g. 3,3)"
    end_pos = gets.chomp
    x_end = end_pos[0].to_i
    y_end = end_pos[2].to_i

    @board[[x_start,y_start]].perform_moves([[x_end, y_end]])



    # until check_available_jump == false
#       begin
#         "Next"
#         move_sequence = [[x_end, y_end]]
#       rescue CannotMoveThere
#         puts "You cannot move your piece there.  Move to another space."
#         retry
#       end
#     end
  end

      #check_end_pos - raise error if not empty, raise error if jump chosen
      # but jump not available

    #   @board[[x,y]].move #name this something else - moves the piece
  #     # 1) if one jump available, make it, check if another jump is available
  #   end
  # end

  def check_if_player_piece(start_pos,color)
    if @board[start_pos].color != self.color
      raise NotYoPieceError
    end
  end

  def check_if_available_move(start_pos, color)
    raise NoAvailableMoveError if @board[start_pos].moves.empty?
  end

  def check_available_jumps
    #check in move sequence for available jumps -
    # if one exists, player must take it
    raise MustTakeJump
  end

  def check_end_pos(end_pos, color)
    raise CannotMoveThere if !@board[start_pos].moves.include?(end_pos)
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

  attr_reader :color

  def initialize(name, color)
    @name = name
    @color = color.to_sym
  end

end

p1 = HumanPlayer.new("Bob", "white")

p2 = HumanPlayer.new("Steve", "black")

game = Game.new(p1, p2)
game.play


class NotYoPieceError < StandardError
end

class MustTakeJump < StandardError
end

class CannotMoveThere < StandardError
end
