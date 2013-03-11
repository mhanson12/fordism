module Fordism
  class Process < RGL::DirectedAdjacencyGraph
    attr_reader :name

    def initialize(args={})
      @name    = args[:name]
      @manager = args[:manager]
      super
    end

    # graph methods
    alias :has_conveyor? :has_edge?
    alias :add_conveyor  :add_edge
    alias :add_station   :add_vertex
    alias :conveyors     :edges
    alias :each_conveyor :each_edge
    alias :stations      :vertices
    alias :each_station  :each_vertex

    # process methods
    def belongs_to(manager)
      @manager = manager
      self
    end

    def depends_on
      @manager.needed_for(self)
    end

    def needed_for
      @manager.depends_on(self)
    end

    # Ugly, RGL probably has a better way to do this
    def transitions_to(station)
      stations.select do |origin| 
        @process.has_edge?(origin, station.to_sym)
      end
    end
    
    # Ugly, RGL probably has a better way to do this
    def transitions_from(station)
      stations.select do |destination| 
        @process.has_edge?(station.to_sym, destination)
      end
    end
    

  end
end
