# encoding: utf-8
require 'spec_helper'
describe Fordism::Station do
  subject { station  }
  let(:station) { Fordism::Station.new(name: 'init') }

  context "without a manager" do
    it "should convert to a symbol" do
      station.to_sym.should == :init
    end
    
    it "should be complete" do
      subject.complete?.should be_true
      subject.incomplete?.should be_false
    end

    it "should not be waiting to receive anything" do
      subject.waiting_to_receive.should == []
    end

    it "should not be waiting to send anything" do
      subject.waiting_to_send.should == []
    end

    it "should not have any inlets" do
      subject.inlets.should == []
    end

    it "should not have any outlets" do
      subject.outlets.should == []
    end
  end

  context "with a manager" do
    context "and no other stations" do
      let(:station) { Fordism::Station.new(name: 'init', manager: Fordism::Manager.new) }

      it "should be complete" do
        subject.complete?.should be_true
        subject.incomplete?.should be_false
      end

      it "should have no inlets or outlets" do
        subject.inlets.should == []
        subject.outlets.should == []
      end

      it "should not be waiting for anything" do
        subject.waiting_to_receive.should == []
        subject.waiting_to_send.should == []
      end
    end

    let(:manager)  { Fordism::Manager.new }
    let(:station)  { Fordism::Station.new(name: 'init',   manager: manager) }
    let(:station2) { Fordism::Station.new(name: 'end', manager: manager) }
    
    before do
      manager.add_conveyor(station, station2)
    end
    
    it "should be incomplete" do
      subject.incomplete?.should be_true
      subject.complete?.should be_false
    end

    it "should not be waiting to receive anything" do
      subject.waiting_to_receive.should == []
    end

    it "should be waiting to send something" do
      subject.waiting_to_send.should == [:end]
    end

    it "should not have any inlets" do
      subject.inlets.should == []
    end

    it "should have any outlet" do
      subject.outlets.should == [:end]
    end
  end
end
