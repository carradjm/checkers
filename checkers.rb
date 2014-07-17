class Piece

  MOVE_DELTAS = [[1,1],
                 [-1,-1],
                 [-1,1],
                 [1,-1]]

  CAPTURE_MOVES = [[2,2],
                   [-2,-2],
                   [-2,2],
                   [2,-2]]



  def initialize(loc, board, color)
    @color = color
    @king = false
  end

  def move_diffs
  end

  def perform_jump
  end

  def perform_slide
  end

  def perform_moves!(*moves)
  end

  def valid_move_seq
  end



end

class Board

  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end


end

