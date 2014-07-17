class Piece

  SLIDE_DELTAS = [[1,1],
                 [-1,-1],
                 [-1,1],
                 [1,-1]]

  JUMP_DELTAS = [[2,2],
                   [-2,-2],
                   [-2,2],
                   [2,-2]]

  attr_accessor :position

  attr_reader :board, :color

  def initialize(position, board, color)
    @color = color
    @king = false
    @position = position
  end

  def move_diffs
  end

  def perform_jump(start_pos, end_pos)
    true

  end

  def perform_slide(start_pos, end_pos)
    #changes the position of self to the end pos; sets the start pos as empty
    if !board[end_pos].nil?
      raise IllegalMoveError
      puts "Can't move there!"
      return false
    end
    self.position = end_pos
    self.board[start_pos] = nil

    true
  end

  def perform_moves!(*moves)
  end

  def moves
    moves = []

    SLIDE_DELTAS.each do |dx, dy|
      moves << [self.location[0] + dx][self.location[1] + dy]
    end

    JUMP_DELTAS.each do |dx, dy|
      moves << [self.location[0] + dx][self.location[1] + dy]
    end

    moves.select {|move| board.on_board?(move)}

    moves
  end

  def valid_move_seq
  end

  def maybe_promote
  end

end

class IllegalMoveError < StandardError
end