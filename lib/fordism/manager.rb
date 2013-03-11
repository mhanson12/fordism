# A manager is responsible for overseeing a process
# Processes are modeled by directed adjacency graphs
# Processes may have dependencies on other processes
module Fordism
  class Manager
    attr_reader :name
    attr_reader :process

    def initialize(name, process)
      @name    = name
      @process = process.belongs_to(self)
    end
    
    def add_conveyor(args={})
      from = args[:from].to_sym
      to   = args[:to].to_sym
      @process.add_conveyor(from, to)
    end
    
    def has_conveyor?(args={})
      from = args[:from].to_sym
      to   = args[:to].to_sym
      @process.has_conveyor?(from, to)
    end

    def manage(station)
      station.report_to(self)
    end

    def add_station(station)
      @process.add_station(station)
    end

    private

    def stations(process)
      @process.stations
    end

    def conveyors(process)
      @process.conveyors
    end
  end
end
