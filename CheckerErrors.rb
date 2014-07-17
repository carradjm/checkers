module CheckerErrors
  def check_if_player_piece(start_pos,color)
    if @board[start_pos].color != color
      raise NotYoPieceError
    end
  end

  def check_if_available_move(start_pos, color)
    raise NoAvailableMoveError if @board[start_pos].moves.empty?
  end

  def check_if_moveable_spot(start_pos, end_pos)
    raise CannotMoveThere if !@board[start_pos].moves.include?(end_pos)
  end

  def check_available_jumps(color)
    player_pieces = @board.grid.flatten.compact.select do |x|
        x.color == color
      end

    raise MustTakeJump if player_pieces.any? do |piece|
      piece.capturable_pieces?
    end
  end

end

class NotYoPieceError < StandardError
end

class MustTakeJump < StandardError
end

class CannotMoveThere < StandardError
end

class NoAvailableMoveError < StandardError
end

class InvalidMoveError < StandardError
end
