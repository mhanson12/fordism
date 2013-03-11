# encoding: utf-8
require 'spec_helper'
describe Fordism::Conveyor do
  subject { conveyor }
  let(:station1) { Fordism::Station.new(name: 'init') }
  let(:station2) { Fordism::Station.new(name: 'complete') }

  context "with a block" do
    let(:conveyor) { Fordism::Conveyor.new(:station1, :station2) }

    context "before running" do
      it "should run" do
        subject.run.should be_true
      end
      it "should be incomplete" do
        subject.complete?.should be_false
      end
    end

    context "after running" do
      before do
        subject.run
      end
      it "should be complete" do
        subject.complete?.should be_true
      end
    end
  end
  
  context "without a block" do
    let(:conveyor) do
      Fordism::Conveyor.new(:station1, :station2) do
        "running"
      end
    end
    context "before running" do
      it "should run" do
        subject.run.should == "running"
      end
      it "should be incomplete" do
        subject.complete?.should be_false
      end
    end
    context "after running" do
      before do
        subject.run
      end
      it "should be complete" do
        subject.complete?.should be_true
      end
    end
  end
end