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

  attr_reader :board, :color, :king

  def initialize(position, board, color)
    @color = color
    @king = false
    @position = position
    @board = board
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
    move_pos = []

    SLIDE_DELTAS.each do |dx, dy|
      move_pos << [self.position[0] + dx, self.position[1] + dy]
    end

    JUMP_DELTAS.each do |dx, dy|
      move_pos << [self.position[0] + dx, self.position[1] + dy]
    end

    move_pos.select! {|move| board.on_board?(move) && board[move].nil?}

    if self.king == false
      return move_pos.select {|move| move[1] > self.position[1]}
    end


  end

  def valid_move_seq
  end

  def maybe_promote
  end

  def display
    color == :white ? "☠" : "⛔"
  end
end

class IllegalMoveError < StandardError
end