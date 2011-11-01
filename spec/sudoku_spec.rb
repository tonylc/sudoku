require 'spec_helper'

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
  let(:medium_board) {
    "4,3,0,0,9,0,0,6,2,
     0,0,8,0,0,0,3,0,0,
     0,0,0,4,0,1,0,0,0,
     6,2,0,0,0,0,0,9,8,
     0,0,0,3,0,2,0,0,0,
     1,8,0,0,0,0,0,3,5,
     0,0,0,5,0,7,0,0,0,
     0,0,2,0,0,0,4,0,0,
     5,4,0,0,6,0,0,7,1"
  }

  it "should be able to print a board" do
    s = Sudoku.new(super_easy_board)
    s.print_board
  end

  describe "#initialization" do
    it "should set all possibles for a super easy board" do
      s = Sudoku.new(super_easy_board)
      s.possibles(0,0).should == [1,3]
      s.possibles(4,3).should == [6,9]
      s.possibles(7,6).should == [1,3]
    end

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
  end
end
