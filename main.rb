# frozen_string_literal: true

require_relative 'core/server'

Message = Struct.new(:from, :value) {}

Core::Server.new(8888).start
