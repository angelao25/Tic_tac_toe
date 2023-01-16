class Position

  attr_accessor :board, :turn
  def initialize board=nil, turn="x"
    @dim = 3
    @size = @dim * @dim
    @board = board || Array.new(@size, "-")
    @turn = turn
    @movelist = []
  end 

  def other_turn
    @turn == "x" ? "o" : "x"
  end

  def move idx
    @board[idx] = @turn
    @turn = other_turn
    @movelist << idx
    self
  end

  def unmove
    @board[@movelist.pop] = "-"
    @turn = other_turn
    self
  end
  
  def possible_moves
    @board.map.with_index { |piece, idx| piece == "-" ? idx : nil}.compact
  end

  def win_lines
    (0..@size.pred).each_slice(@dim).to_a +
    (0..@size.pred).each_slice(@dim).to_a.transpose +
    [ (0..@size.pred).step(@dim.succ).to_a] +
    [ (@dim.pred..(@size-@dim)).step(@dim.pred).to_a ]
  end
end