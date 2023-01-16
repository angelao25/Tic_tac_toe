require 'spec_helper'
require 'ttt'

describe Position do
  context "#new" do
    it "should initialize a new board" do
      position = Position.new
      position.board.should == %w(- - -
                                  - - -
                                  - - -)
      position.turn.should == "x"
    end

    it "should initialize a position given a board and turn" do
      position = Position.new(%w(- x -
                                 - - -
                                 - o -), "o")
      position.board.should == %w(- x -
                                  - - -
                                  - o -)
      position.turn.should == "o"
    end
  end
  context "#move" do
    it "should make a move" do
      position = Position.new.move(0)
      position.board.should == %w(x - -
                                  - - -
                                  - - -)
      position.turn.should == "o"
    end
  end

  context "unmove" do
    it "should undo a move" do
      position = Position.new.move(1).unmove
      init = Position.new
      position.board.should == init.board
      position.turn.should == init.turn
    end
  end

  context "#possible_moves" do
    it "should list possible moves for initial position" do
      Position.new.possible_moves.should == (0..8).to_a
    end
    it "should list possible moves for a position" do
      Position.new.move(3).possible_moves.should == [0,1,2,4,5,6,7,8]
    end
  end
  context "#win_lines" do
    it "should find winning columns, rows, diagonals" do
      win_lines = Position.new(%w(0 1 2
                                   3 4 5
                                   6 7 8)).win_lines
      win_lines.should include([0,1,2])
      win_lines.should include([3,4,5])
      win_lines.should include([6,7,8])
      win_lines.should include([0,3,6])
      win_lines.should include([1,4,7])
      win_lines.should include([2,5,8])
      win_lines.should include([0,4,8])
      win_lines.should include([2,4,6])


    end
  end
end