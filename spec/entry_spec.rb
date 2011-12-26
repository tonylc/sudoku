require 'spec_helper'

describe Entry do

  describe "given an initial value of 5" do
    let(:entry) { Entry.new(5) }

    it "should have a value of 5" do
      entry.val.should == 5
    end

    it "should have no possible values" do
      entry.possibles.should be_empty
    end
  end

  describe "given an initial value of 0" do
    let(:entry) { Entry.new(0) }

    it "should have a value of 0" do
      entry.val.should == 0
    end

    it "should set all possible values to 1-9" do
      entry.possibles.should == [1,2,3,4,5,6,7,8,9]
    end
  end

  describe "#remove_from_possible" do
    let(:entry) { Entry.new(0) }

    it "should show the difference" do
      entry.remove_from_possible(2)
      entry.possibles.should == [1,3,4,5,6,7,8,9]

      entry.remove_from_possible(2,4,6)
      entry.possibles.should == [1,3,5,7,8,9]
    end

    it "should automatically set value if there's only one possible left" do
      entry.remove_from_possible(1,2,3,4,6,7,8,9)
      entry.possibles.should == [5]
      entry.val.should == 5
    end
  end

  describe "#set_possibles" do
    let(:entry) { Entry.new(0) }

    it "should set new possibles" do
      entry.set_possibles(1,2,3)
      entry.possibles.should == [1,2,3]
    end

    it "should automatically set value if there's only one possible left" do
      entry.set_possibles(5)
      entry.possibles.should == [5]
      entry.val.should == 5
    end
  end

  describe "printing possibles" do
    let(:entry) { Entry.new(0) }

    describe "for the top position" do
      it "should print all possibles" do
        entry.set_possibles(1,2,3,4,5,6,7,8,9)
        entry.print_top_possibles.should == "123"
      end

      it "should print only some possibles" do
        entry.set_possibles(1,3)
        entry.print_top_possibles.should == "1 3"
      end

      it "should only print the value if its already set" do
        Entry.new(2).print_top_possibles.should == " 2 "
      end

      it "should not print anything if the set value is not within position" do
        Entry.new(4).print_top_possibles.should == "   "
      end
    end

    describe "for the middle position" do
      it "should print all possibles" do
        entry.set_possibles(1,2,3,4,5,6,7,8,9)
        entry.print_middle_possibles.should == "456"
      end

      it "should print only some possibles" do
        entry.set_possibles(4,5)
        entry.print_middle_possibles.should == "45 "
      end

      it "should only print the value if its already set" do
        Entry.new(4).print_middle_possibles.should == "4  "
      end

      it "should not print anything if the set value is not within position" do
        Entry.new(9).print_middle_possibles.should == "   "
      end
    end

    describe "for the bottom position" do
      it "should print all possibles" do
        entry.set_possibles(7,8,9)
        entry.print_bottom_possibles.should == "789"
      end

      it "should print only some possibles" do
        entry.set_possibles(1,2,3,4,5,6,9)
        entry.print_bottom_possibles.should == "  9"
      end

      it "should only print the value if its already set" do
        Entry.new(9).print_bottom_possibles.should == "  9"
      end

      it "should not print anything if the set value is not within position" do
        Entry.new(1).print_bottom_possibles.should == "   "
      end
    end
  end
end
