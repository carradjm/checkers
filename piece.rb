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

  def perform_jump(start_pos, end_pos)
    true
  end

  def perform_slide(start_pos, end_pos)
    true
  end

  def perform_moves!(*moves)
  end

  def valid_move_seq
  end

  def maybe_promote
  end

end