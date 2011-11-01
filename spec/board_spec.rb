require 'spec_helper'

describe Board do
  describe "#initialization" do
    it "should be able to print a board" do
      b = Board.new("4,3,0,0,9,0,0,6,2,
                     0,0,8,0,0,0,3,0,0,
                     0,0,0,4,0,1,0,0,0,
                     6,2,0,0,0,0,0,9,8,
                     0,0,0,3,0,2,0,0,0,
                     1,8,0,0,0,0,0,3,5,
                     0,0,0,5,0,7,0,0,0,
                     0,0,2,0,0,0,4,0,0,
                     5,4,0,0,6,0,0,7,1")
      b.print_board
    end

    describe "#validation errors" do
      it "should raise if there aren't exactly 81 numbers" do
        lambda do
          Board.new("4,3,0,0,9,0,0,6,2,
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
          Board.new("4,3,0,4,9,0,0,6,2,
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
          Board.new("4,3,0,0,9,0,0,6,2,
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
          Board.new("4,3,0,0,9,0,0,6,2,
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
