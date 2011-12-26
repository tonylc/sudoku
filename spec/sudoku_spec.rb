require 'spec_helper'
require 'benchmark'

describe Sudoku do
  let(:super_easy_board) {
    "0,5,9,0,4,0,6,8,0,
     7,2,0,5,0,3,9,0,0,
     4,0,0,0,1,6,2,5,0,
     0,6,7,1,0,0,0,2,8,
     0,0,2,0,3,8,7,0,1,
     8,0,4,7,0,2,0,9,0,
     0,4,0,3,7,5,0,0,2,
     6,0,8,4,0,0,0,7,5,
     2,7,0,0,6,0,4,0,9"
  }
  let(:easy_board) {
    "0,2,0,1,6,0,4,0,0,
     0,7,4,9,2,3,0,0,0,
     9,0,1,0,0,7,5,0,0,
     6,0,0,0,9,0,1,0,8,
     0,0,0,0,3,0,0,0,0,
     7,0,5,0,8,0,0,0,2,
     0,0,6,2,0,0,8,0,5,
     0,0,0,3,7,4,2,1,0,
     0,0,7,0,5,8,0,3,0"
  }
  let(:medium_board) {
    "0,4,0,8,0,6,0,0,0,
     0,0,0,5,0,0,0,0,1,
     8,5,9,0,0,0,0,4,6,
     0,3,0,7,0,5,0,0,2,
     4,0,5,0,0,0,3,0,8,
     2,0,0,9,0,4,0,1,0,
     5,2,0,0,0,0,1,3,9,
     9,0,0,0,0,1,0,0,0,
     0,0,0,6,0,9,0,2,0"
  }
  # let(:medium_board) {
  #   "4,3,0,0,9,0,0,6,2,
  #    0,0,8,0,0,0,3,0,0,
  #    0,0,0,4,0,1,0,0,0,
  #    6,2,0,0,0,0,0,9,8,
  #    0,0,0,3,0,2,0,0,0,
  #    1,8,0,0,0,0,0,3,5,
  #    0,0,0,5,0,7,0,0,0,
  #    0,0,2,0,0,0,4,0,0,
  #    5,4,0,0,6,0,0,7,1"
  # }

  it "should be able to print a board" do
    s = Sudoku.new(super_easy_board)
    s.print_board
  end

  it "should be able to print a board with its possibles" do
    s = Sudoku.new(super_easy_board)
    s.print_board_with_possibles
  end

  it "should be able to solve a super easy board" do
    counter = 0
    time = Benchmark.realtime do
      s = Sudoku.new(super_easy_board)
      counter = s.solve!
      s.valid_final_board?.should be_true
    end
    p "**** Time it took to solve super easy board: #{time}, #{counter} iterations"
  end

  it "should be able to solve a easy board" do
    counter = 0
    time = Benchmark.realtime do
      s = Sudoku.new(easy_board)
      counter = s.solve!
      s.valid_final_board?.should be_true
    end
    p "**** Time it took to solve easy board: #{time}, #{counter} iterations"
  end

  it "should be able to solve a medium board" do
    counter = 0
    time = Benchmark.realtime do
      s = Sudoku.new(medium_board)
      counter = s.solve!
      s.valid_final_board?.should be_true
    end
    p "**** Time it took to solve medium board: #{time}, #{counter} iterations"
  end

  describe "#initialization" do
    # it "should set all possibles for a super easy board" do
    #   s = Sudoku.new(medium_board)
    #   s.possibles(0,0).should == []
    #   s.possibles(4,3).should == [6,9]
    #   s.possibles(7,6).should == [1,3]
    # end

    it "should find quadrants by entries" do
      s = Sudoku.new(super_easy_board)
      s.send(:find_quad_by_entry, 0, 7).should == 2
      s.send(:find_quad_by_entry, 1, 7).should == 2
      s.send(:find_quad_by_entry, 2, 8).should == 2
      s.send(:find_quad_by_entry, 6, 7).should == 8
    end

    describe "validation errors" do
      it "should raise if there aren't exactly 81 numbers" do
        lambda do
          Sudoku.new("4,3,0,0,9,0,0,6,2,
                     0,0,8,0,0,0,3,0,0,
                     0,0,0,4,0,1,0,0,0,
                     6,2,0,0,0,0,0,9,8,
                     0,0,0,3,0,2,0,0,0,
                     1,8,0,0,0,0,0,3,5,
                     0,0,0,5,0,7,0,0,0,
                     0,0,2,0,0,0,4,0,0,
                     5,4,0,0,6,0,0,7,1,7")
        end.should raise_error
      end

      it "should raise if the board has more than 2 of the same numbers per row" do
        lambda do
          Sudoku.new("4,3,0,4,9,0,0,6,2,
                     0,0,8,0,0,0,3,0,0,
                     0,0,0,4,0,1,0,0,0,
                     6,2,0,0,0,0,0,9,8,
                     0,0,0,3,0,2,0,0,0,
                     1,8,0,0,0,0,0,3,5,
                     0,0,0,5,0,7,0,0,0,
                     0,0,2,0,0,0,4,0,0,
                     5,4,0,0,6,0,0,7,1")
        end.should raise_error
      end

      it "should raise if the board has more than 2 of the same numbers per column" do
        lambda do
          Sudoku.new("4,3,0,0,9,0,0,6,2,
                     0,0,8,0,0,0,3,0,0,
                     0,0,0,4,0,1,0,7,0,
                     6,2,0,0,0,0,0,9,8,
                     0,0,0,3,0,2,0,0,0,
                     1,8,0,0,0,0,0,3,5,
                     0,0,0,5,0,7,0,0,0,
                     0,0,2,0,0,0,4,0,0,
                     5,4,0,0,6,0,0,7,1")
        end.should raise_error
      end

      it "should raise if the board has more than 2 of the same numbers per quadrant" do
        lambda do
          Sudoku.new("4,3,0,0,9,0,0,6,2,
                     0,0,8,0,0,0,3,0,0,
                     0,0,0,4,0,1,0,0,0,
                     6,2,0,0,0,0,0,9,8,
                     0,0,0,3,0,2,0,0,0,
                     1,8,0,0,0,0,0,3,5,
                     0,0,0,5,0,7,0,0,0,
                     0,0,2,0,0,0,4,0,7,
                     5,4,0,8,6,0,0,7,1")
        end.should raise_error
      end
    end

    describe "#set_board" do
      it "should set the board" do
        s = Sudoku.new
        lambda { s.set_board(super_easy_board) }.should_not raise_error
      end

      it "should raise error if trying to set a board that's already been initialized" do
        s = Sudoku.new(super_easy_board)
        lambda { s.set_board(super_easy_board) }.should raise_error
      end
    end
  end
end
