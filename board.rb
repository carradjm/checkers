require_relative 'piece.rb'

class Board

  def initialize(duplicate = false)
    @grid = Array.new(8) {Array.new(8)}
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
  end
end