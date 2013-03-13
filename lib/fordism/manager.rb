# A manager is responsible for overseeing a process
module Fordism
  class Manager
    attr_reader :name
    attr_reader :process
    attr_reader :line_workers

    def initialize(name, process)
      @name    = name.to_sym
      @process = process.belongs_to(self)
    end
    
    def add_conveyor(args={})
      @process.add_conveyor(*from_to(args))
    end
    
    def has_conveyor?(args={})
      @process.has_conveyor?(*from_to(args))
    end

    def add_station(station)
      @process.add_station(station)
    end

    def has_station?(station)
      @process.has_station?(station.to_sym)
    end

    private

    def manage(station)
      station.report_to(self)
    end

    def stations(process)
      @process.stations
    end

    def conveyors(process)
      @process.conveyors
    end

    def from_to(args)
      from, to = args[:from].to_sym, args[:to].to_sym
    end
  end
end
