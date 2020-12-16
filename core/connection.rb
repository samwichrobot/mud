# frozen_string_literal: true

require 'delegate'

module Core
  # Connection
  class Connection < SimpleDelegator
    def read_line
      gets.strip
    end

    def write_line(line)
      puts line
    end
  end
end
