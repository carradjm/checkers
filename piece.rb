require 'debugger'
require_relative 'CheckerErrors.rb'

class Piece
include CheckerErrors

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

  def capturable_pieces?

    capture_pos = []

    SLIDE_DELTAS.each do |dx, dy|
      capture_pos << [self.position[0] + dx, self.position[1] + dy]
    end

    capture_pos.select! {|pos| @board.on_board?(pos)}

    capture_pos.select! {|pos| !@board[pos].nil?}

    return true if capture_pos.any? { |pos| @board[pos].color != self.color }
    false
  end

  def perform_jump(end_pos)

    start_pos = self.position

    if !@board[end_pos].nil? || @board[start_pos].nil?
      return false
    end

    #return false if trying to run #perform_jump on a slide end_pos
    if end_pos[0] - start_pos[0] == 1
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
      return false
    end

    maybe_promote
    true
  end

  def perform_slide(end_pos)
    #changes the position of self to the end pos; sets the start pos as empty
    start_pos = self.position

    if !@board[end_pos].nil? || @board[start_pos].nil?
      return false
    end

    if end_pos[0] - start_pos[0] != 1
      return false
    end

    if self.moves.include?(end_pos)
      @board[end_pos] = @board[start_pos]
      @board[end_pos].position = end_pos
      @board[start_pos] = nil
    else
      return false
    end

    maybe_promote
    true
  end

  def perform_moves!(move_sequence)
    if move_sequence.count > 1
      until move_sequence.empty?
        if perform_jump(move_sequence[0]) == false
          raise InvalidMoveError
        else
          perform_jump(move_sequence[0])
          move_sequence.shift
        end
      end
    else
      if self.capturable_pieces? == true
        if perform_jump(move_sequence[0]) == false
          puts "you dun fked up"
          raise InvalidMoveError
        else
          perform_jump(move_sequence[0])
        end
      end

      if perform_slide(move_sequence[0]) == false
        puts "you dun fked up"
        raise InvalidMoveError
      else
          perform_jump(move_sequence[0])
      end
    end
  end

  def valid_move_seq?(move_sequence)
    #call on a duped board
    dup_board = board.dup

    #allows me to grab the same piece on the duplicate board
    dup_piece = dup_board[[self.position[0],self.position[1]]]


    move_sequence.each do |move|
      begin
        dup_piece.perform_moves!([move])
      rescue InvalidMoveError
        puts "you dun fuked up"
        return false
      end
    end

    true
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError
    end
  end

  def maybe_promote
    last_rank = (color = :white ? 7 : 0)

    if self.position[1] == last_rank
      self.king == true
    end
  end

  def display
    color == :white ? "⚽" : "⛔"
  end

  def inspect
    [self.color,self.position, self.king].inspect
  end

  def dup(new_board)
     Piece.new(position,new_board,color)
  end

end