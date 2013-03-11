require 'manager'
require 'stations'
require 'conveyor'

module Fordism
  class Factory
    # Metadata
    attr_reader :name

    # Employees
    attr_reader :managers

    # Machinery
    attr_reader :stations, :conveyors
    
    def initialize(args={})
      @name     = args[:name]
      @managers = args[:manager]
    end

    def stations
      @managers.
    end

  end
end
