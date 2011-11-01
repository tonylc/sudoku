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
end
