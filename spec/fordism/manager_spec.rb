# encoding: utf-8
require 'spec_helper'
describe Fordism::Manager do
  subject { manager  }
  let(:manager) { Fordism::Manager.new }

  it "should be able to create stations" do
    direct   = Fordism::Station.new(name: :init, manager: manager)
    implicit = manager.create_station(name: :init)
    implicit.should == direct
  end

  context "without a conveyor" do
    it "should not be able to find a conveyor" do
      subject.find_conveyor(:station1, :station2).should be_nil
    end
    
    it "should have no transitions" do
      subject.transitions_to(:station1).should == []
      subject.transitions_to(:station2).should == []
      subject.transitions_from(:station1).should == []
      subject.transitions_from(:station2).should == []
    end
  end

  context "with a conveyor" do
    before do
      subject.add_conveyor(:station1, :station2) { "effect"}
    end

    it "should be able to find that conveyor" do
      subject.find_conveyor(:station1, :station2).should_not be_nil
    end
    
    it "should be able to find stations that transition to another" do
      subject.transitions_to(:station1).should == []
      subject.transitions_to(:station2).should == [:station1]
    end
    
    it "should be able to find stations that transition from another" do
      subject.transitions_from(:station1).should == [:station2]
      subject.transitions_from(:station2).should == []
    end
  end

  context "with multiple conveyors from the same station" do
    before do
      subject.add_conveyor(:station1, :station2) { "effect"}
      subject.add_conveyor(:station1, :station3) { "effect2"}
    end

    it "should be able to find those conveyors" do
      subject.find_conveyor(:station1, :station2).should_not be_nil
      subject.find_conveyor(:station1, :station3).should_not be_nil
    end
    
    it "should be able to find stations that transition to another" do
      subject.transitions_to(:station1).should == []
      subject.transitions_to(:station2).should == [:station1]
      subject.transitions_to(:station3).should == [:station1]
    end
    
    it "should be able to find stations that transition from another" do
      subject.transitions_from(:station1).should =~ [:station3, :station2]
      subject.transitions_from(:station2).should == []
      subject.transitions_from(:station3).should == []
    end
  end

  context "with multiple conveyors to the same station" do
    before do
      subject.add_conveyor(:station1, :station2) { "effect"}
      subject.add_conveyor(:station3, :station2) { "effect2"}
    end

    it "should be able to find those conveyors" do
      subject.find_conveyor(:station1, :station2).should_not be_nil
      subject.find_conveyor(:station3, :station2).should_not be_nil
    end
    
    it "should be able to find stations that transition to another" do
      subject.transitions_to(:station1).should == []
      subject.transitions_to(:station2).should =~ [:station1, :station3]
      subject.transitions_to(:station3).should == []
    end
    
    it "should be able to find stations that transition from another" do
      subject.transitions_from(:station1).should =~ [:station2]
      subject.transitions_from(:station2).should == []
      subject.transitions_from(:station3).should == [:station2]
    end
  end

  context "with a junction station" do
    before do
      subject.add_conveyor(:station1, :station3) { "effect"}
      subject.add_conveyor(:station2, :station3) { "effect2"}
      subject.add_conveyor(:station3, :station4) { "effect3"}
      subject.add_conveyor(:station3, :station5) { "effect4"}
    end

    it "should be able to find those conveyors" do
      subject.find_conveyor(:station1, :station3).should_not be_nil
      subject.find_conveyor(:station2, :station3).should_not be_nil
      subject.find_conveyor(:station3, :station4).should_not be_nil
      subject.find_conveyor(:station3, :station5).should_not be_nil
    end
    
    it "should be able to find stations that transition to another" do
      subject.transitions_to(:station1).should == []
      subject.transitions_to(:station2).should == []
      subject.transitions_to(:station3).should =~ [:station1, :station2]
      subject.transitions_to(:station4).should == [:station3]
      subject.transitions_to(:station5).should == [:station3]
    end
    
    it "should be able to find stations that transition from another" do
      subject.transitions_from(:station1).should == [:station3]
      subject.transitions_from(:station2).should == [:station3]
      subject.transitions_from(:station3).should =~ [:station4, :station5]
      subject.transitions_from(:station4).should == []
      subject.transitions_from(:station5).should == []
    end
  end
end
