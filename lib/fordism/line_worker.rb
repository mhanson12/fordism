# A Line Worker are responsible for overseeing a station
module Fordism
  class LineWorker
    def initialize(args={})
      @manager = args[:manager]
      @station = args[:station]
    end
  end
end
