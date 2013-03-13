# encoding: utf-8
require 'spec_helper'
describe Fordism::Station do
  let(:adder) do
    Fordism::Station.new(:adder) do |i|
      @side = "effect"
      i += 1
    end
  end
  let(:coupled) do
    Fordism::Station.new(:coupled) do |numerator, denominator|
      numerator / denominator
    end
  end
  let(:faulty) do
    Fordism::Station.new(:faulty) do
      false
    end
  end
  let(:working) do
    Fordism::Station.new(:working) do
      true
    end
  end

  context "with an incoming queue" do
    let(:jobs) {(1..10).collect{|i| [i, 1]}}

    it "should be able to queue a job" do
      coupled.queue_job(1,1).should =~ [[1,1]]
    end

    it "should be able to queue a batch" do
      coupled.queue_batch(*jobs).should =~ jobs
    end

    it "should be able to process a job" do
      coupled.queue_job(jobs.first)
      coupled.process_job
      coupled.completed_jobs.should == [1]
    end

    it "should be able to process a batch" do
      coupled.queue_batch([4,2], [9,3])
      coupled.process_batch(size: 2)
      coupled.review_all.should =~ [3,2]
    end

    it "should be able to process all jobs in the queue" do
      coupled.queue_batch(*jobs)
      coupled.process_all
      coupled.review_all.should =~ (1..10).collect{|i| i}
    end
  end
end




=begin
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
=end
