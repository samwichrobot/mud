# frozen_string_literal: true

module Core
  # ConnectionManager
  class ConnectionManager
    attr_accessor :mutex
    attr_accessor :connections
    attr_accessor :queue

    def initialize
      self.mutex       = Mutex.new
      self.connections = []
    end

    def add(connection)
      mutex.synchronize do
        connections << connection
      end
    end

    def remove(connection)
      mutex.synchronize do
        connections.delete connection
      end
    end

    def each
      mutex.synchronize do
        connections.each do |conn|
          yield conn
        end
      end
    end

    def length
      connections.length
    end
  end
end
