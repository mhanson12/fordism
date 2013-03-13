$LOAD_PATH << File.dirname(__FILE__)

require 'stations/source'
require 'stations/sink'
require 'stations/joint'

# A station is a wrapper around the block that executes state specific code
# It is unaware of its line-worker
module Fordism
  class Station
    attr_reader :name
    attr_reader :block

    def initialize(name, &block)
      @name   = name.to_sym
      @block  = block
    end

    def to_sym
      @name.to_sym
    end

    def ==(other)
      self.name == other.name
    end

    ### Operational methods

    
    ## Queue methods

    # Queue a job
    def queue_job(*job)
      @incoming = incoming + [job]
    end

    # Queue a set of jobs
    def queue_batch(*jobs)
      @incoming = incoming + jobs
    end

    ## Dequeue methods

    # Process 1 job; Syntactic sugar for process_batch(1)
    def process_job
      process_batch(size: 1)
    end

    # Process n jobs
    def process_batch(args={})
      args[:size]
      incoming.size
      incoming
      size = batch_size(args[:size])
      run_batch_of_size(size)
    end
    
    # Process continuously until the queue is empty
    def process_all
      process_batch(size: incoming.size) while !incoming.empty?
    end

    def open?
      incoming.empty?
    end

    def closed?
      not open?
    end

    def completed_jobs
      outgoing
    end

    def review_all
      result = outgoing.dup
      @outgoing = []
      result
    end

    private

    def batch_size(proposed)
      case
      when proposed > incoming.size then incoming.size
      else proposed
      end
    end

    def run_batch_of_size(size)
      size.times do
        run
      end
    end

    def run
      args = incoming.shift
      result = block.call(*args)
      outgoing << result
      result
    end

    def review
      outgoing.shift
    end

    def run_all(*jobs)
      jobs.collect do |job|
        run
      end
    end

    def incoming
      @incoming ||= []
    end

    def outgoing
      @outgoing ||= []
    end
  end
end
