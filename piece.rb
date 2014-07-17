class Piece

  SLIDE_DELTAS = [[1,1],
                 [-1,-1],
                 [-1,1],
                 [1,-1]]

  JUMP_DELTAS = [[2,2],
                   [-2,-2],
                   [-2,2],
                   [2,-2]]

  attr_accessor :position, :king

  attr_reader :board, :color, :king

  def initialize(position, board, color)
    @color = color
    @king = false
    @position = position
    @board = board
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
      if self.color == :white
        return move_pos.select {|move| move[1] > self.position[1]}
      else
        return move_pos.select {|move| move[1] < self.position[1]}
      end
    end
  end

  def perform_jump(end_pos)

    start_pos = self.position

    if !@board[end_pos].nil? || @board[start_pos].nil?
      raise IllegalMoveError
      puts "Can't move there!"
      return false
    end

    move_direction = [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]

    move_direction_index = JUMP_DELTAS.index(move_direction)

    jumped_piece_direction = SLIDE_DELTAS[move_direction_index]

    jumped_piece_location = [start_pos[0] + jumped_piece_direction[0], start_pos[1] + jumped_piece_direction[1]]

    @board[jumped_piece_location] = nil

    if self.moves.include?(end_pos)
      @board[end_pos] = @board[start_pos]
      @board[end_pos].position = end_pos
      @board[start_pos] = nil
    else
      raise IllegalMoveError
      puts "Can't move there!"
      return false
    end

    true
  end

  def perform_slide(end_pos)
    #changes the position of self to the end pos; sets the start pos as empty
    start_pos = self.position

    if !@board[end_pos].nil? || @board[start_pos].nil?
      raise IllegalMoveError
      puts "Can't move there!"
      return false
    end

    if self.moves.include?(end_pos)
      @board[end_pos] = @board[start_pos]
      @board[end_pos].position = end_pos
      @board[start_pos] = nil
    else
      raise IllegalMoveError
      puts "Can't move there!"
      return false
    end

    true
  end

  def perform_moves!(*moves)
  end

  def valid_move_seq
  end

  def maybe_promote
    last_rank = (color = :white ? 7 : 0)

    if self.position[1] == last_rank
      self.king == true
    end
  end

  def display
    color == :white ? "☠" : "⛔"
  end

  def inspect
    [self.color,self.position, self.king].inspect
  end

end

class IllegalMoveError < StandardError
end