require_relative 'piece.rb'
require 'colorize'
require 'debugger'

class Board

  attr_reader :grid

  def initialize(duplicate = false)
    @grid = Array.new(8) {Array.new(8)}
    @pieces = []
    setup_board if !duplicate
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,obj)
    x,y = pos
    @grid[x][y] = obj
    nil
  end

  def on_board?(pos)
    # p [pos[0],pos[1]]

    (0..7).include?(pos[0]) && (0..7).include?(pos[1])
  end

  def setup_board
    white_piece_rows = [0,1,2]

    black_piece_rows = [5,6,7]

    8.times do |x|
      white_piece_rows.each do |y|
        self[[x,y]] = Piece.new([x,y], self, :white) if (x + y) % 2 == 0
      end

      black_piece_rows.each do |y|
        self[[x,y]] = Piece.new([x,y], self, :black) if (x + y) % 2 == 0
      end
    end

    @pieces = @grid.flatten.compact
    nil
  end

  def dup
    dup_board = Board.new(true)

    @grid.flatten.compact.each do |piece|
      dup_board[piece.position] = piece.dup(dup_board)
    end

    dup_board
  end

  def inspect
    display
  end

  def display
       print "   ┌#{"───┬"* (7)}───┐\n".colorize(:light_cyan)

       (0...8).to_a.reverse.each do |y|
         print " #{y}".colorize(:light_black)
         print " │".colorize(:light_cyan)
         8.times do |x|
           if !self[[x,y]].nil?
             print " #{self[[x,y]].display} "
           else
             print "   "
           end
           print "│".colorize(:light_cyan)
         end
         print "\n"
         print "   ├#{"───┼" * (7)}───┤\n".colorize(:light_cyan) unless y == 0
       end
       print "   └#{"───┴"* (7)}───┘\n".colorize(:light_cyan)
       print "     0   1   2   3   4   5   6   7  \n".colorize(:light_black)
       nil
  end

end