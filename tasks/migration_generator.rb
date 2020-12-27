# frozen_string_literal: true

require_relative 'migration_name_generator'
require_relative 'migration_class_generator'

module Tasks
  # MigrationGenerator
  class MigrationGenerator
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def generate
      File.open(path, 'w') do |file|
        file.write(MigrationClassGenerator.generate(name))
      end
    end

    private

    def filename
      @filename ||= MigrationNameGenerator.generate(name)
    end

    def path
      @path ||= File.expand_path("../../db/migrate/#{filename}", __FILE__)
    end
  end
end
