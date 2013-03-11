# encoding: utf-8
require 'spec_helper'
describe Fordism do
  let(:manager)         { Fordism::Manager.new }
  let(:init)            { manager.create_station(name: :init) }
  let(:paint)           { manager.create_station(name: :paint) }
  let(:vacuum)          { manager.create_station(name: :vacuum) }
  let(:wash_interior)   { manager.create_station(name: :wash_interior) }
  let(:clean_wheels)    { manager.create_station(name: :clean_wheels) }
  let(:wash_exterior)   { manager.create_station(name: :wash_exterior) }
  let(:wax_exterior)    { manager.create_station(name: :wax_exterior) }
  let(:detail_exterior) { manager.create_station(name: :detail_exterior) }

  context "without callbacks" do
    context "sequential tasks" do
      before do
        manager.add_conveyor(init, wash_exterior)
        manager.add_conveyor(wash_exterior, wax_exterior)
        manager.add_conveyor(wax_exterior, detail_exterior)
      end

      it "should run" do

      end
    end
    
    context "parallel tasks" do
      
    end
    
    context "complex tasks" do
      
    end
  end

  context "with callbacks" do

  end
end
