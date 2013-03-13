# encoding: utf-8
require 'spec_helper'
describe Fordism::Manager do
  subject { manager  }
  let(:process)  { Fordism::Process.new('Sprocket Assembly')                  }
  let(:manager)  { Fordism::Manager.new('George Jetson', process)             }
  let(:station1) { Fordism::Station.new('mine')     { p "hi-ho"              }}
  let(:station2) { Fordism::Station.new('smelt')    { p "hot!hot!hot!"       }}
  let(:station3) { Fordism::Station.new('shape')    { p "pourrrring"         }}
  let(:station4) { Fordism::Station.new('cool')     { p "borrrrring"         }}
  let(:station5) { Fordism::Station.new('polish')   { p "shiny things"       }}
  let(:station6) { Fordism::Station.new('paint')    { p "take a deep breath" }}
  let(:station7) { Fordism::Station.new('package')  { p "done!"              }}


  it "should be able to add stations" do
    manager.add_station(station1)
    manager.has_station?(station1).should be_true
    manager.has_station?(:mine).should be_true
  end

  context "from a blank slate" do
    it "should be able to add conveyors" do
      manager.add_conveyor(from: station1, to: station2)
      manager.has_conveyor?(from: station1, to: station2).should be_true
    end
  end

  context "with existing process" do
    before do
      manager.add_station(station1)
      manager.add_station(station2)
    end
    
    it "should be able to add conveyors" do
      manager.add_conveyor(to: station1, from: station2)
      manager.has_conveyor?(to: station1, from: station2).should be_true
    end
  end
end
=begin
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
=end
