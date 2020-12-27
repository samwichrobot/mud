# frozen_string_literal: true

require 'socket'

require_relative 'connection'
require_relative 'connection_manager'

# Core
module Core
  BroadcastMessage = Struct.new(:from, :value) {}

  # ServerDefaults
  class ServerDefaults
    def self.options(port)
      { listener: TCPServer.new(port) }
    end
  end

  # Server
  class Server
    attr_reader :listener
    attr_reader :port
    attr_reader :queue
    attr_reader :connections

    def initialize(port, options = ServerDefaults.options(port))
      @port        = port
      @listener    = options[:listener]
      @queue       = Queue.new
      @connections = ConnectionManager.new
    end

    def accept
      Connection.new(listener.accept)
    end

    def broadcast(msg)
      connections.each do |conn|
        conn.write_line(msg.value) unless conn.equal? msg.from
      end
    end

    def start
      Thread.start do
        loop do
          msg = queue.pop
          broadcast(msg)
        end
      end

      loop do
        Thread.start(accept) { |conn| handle(conn) }
      end
    end

    private

    def handle(conn)
      connections.add(conn)

      loop do
        line = conn.read_line.strip
        break if line.eql? 'exit'

        queue << BroadcastMessage.new(conn, line)
      end

      connections.remove(conn)

      conn.close
    end
  end
end
