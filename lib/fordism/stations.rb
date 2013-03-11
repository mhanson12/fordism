$LOAD_PATH << File.dirname(__FILE__)

require 'stations/source'
require 'stations/sink'
require 'stations/joint'

module Fordism
  class Station
    attr_reader :name
    attr_reader :block
    attr_reader :line_worker

    def initialize(args={}, &block)
      @name        = args[:name].to_sym
      @line_worker = args[:line_worker]
      @block       = block
    end

    def 

    def report_to(manager)
      @manager = manager
    end

    def reports_to
      @manager
    end

    def to_sym
      @name.to_sym
    end

    def ==(other)
      self.name == other.name
    end

    # workflow can move to the next station
    def complete?
      waiting_to_receive.empty? and waiting_to_send.empty?
    end

    # workflow cannot move to the next station
    def incomplete?
      !complete?
    end

    # which stations are being waited on?
    def waiting_to_receive
      inlets - received
    end

    def waiting_to_send
      outlets - sent
    end

    def inlets
      @inlets ||= @manager.transitions_to(self) rescue []
    end

    def outlets
      @outlets ||= @manager.transitions_from(self) rescue []
    end

    private

    def get_work_from(other)
      @received << other.to_sym
    end

    def send_work_to(other)
      conveyor = conveyor_for(other)
      conveyor.run
      if conveyor.complete?
        other.get_work_from(self)
        @sent << other.to_sym        
      end
      conveyor.complete?
    end

    def conveyor_for(other)
      @manager.find_conveyor(self, other)
    end
  end
end
