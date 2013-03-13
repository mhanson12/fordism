# A process is a wrapper around a directed adjacency graph
# It is responsible for manipulating the graph object it inherits from
# And has a reference to a manager
module Fordism
  class Process < RGL::DirectedAdjacencyGraph
    attr_reader :name

    def initialize(name)
      @name = name.to_sym
      super(Set)
    end

    # aliased graph methods
    alias :conveyors     :edges
    alias :each_conveyor :each_edge
    alias :stations      :vertices
    alias :each_station  :each_vertex

    # wrapped graph methods
    def add_station(station)
      add_vertex(station.to_sym)
    end
    
    def has_station?(station)
      has_vertex?(station.to_sym)
    end

    def add_conveyor(start, finish)
      add_edge(start.to_sym, finish.to_sym)
    end

    def has_conveyor?(start, finish)
      has_edge?(start.to_sym, finish.to_sym)
    end

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
        has_edge?(origin, station.to_sym)
      end
    end
    
    # Ugly, RGL probably has a better way to do this
    def transitions_from(station)
      stations.select do |destination| 
        has_edge?(station.to_sym, destination)
      end
    end
  end
end
