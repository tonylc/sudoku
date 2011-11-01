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
end
