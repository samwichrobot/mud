# frozen_string_literal: true

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require_relative 'tasks/migration_generator'
require_relative 'tasks/database'
require_relative 'tasks/configuration'

def config
  Tasks::Configuration.get_config
end

namespace :db do
  desc 'Create a new database'
  task :create do
    Tasks::Database.establish_connection(config)
    Tasks::Database.create_database!
    puts 'Database created.'
  end

  desc 'Remove database'
  task :drop do
    database = Tasks::Configuration.get_database_path

    File.delete(database) if File.exist?(database)
  end

  desc 'Run migrations'
  task :migrate do
    Tasks::Database.migrate!(config)
    Rake::Task['db:schema'].invoke
  end

  desc 'Dump database schema'
  task :schema do
    Tasks::Database.dump_schema(config, 'db/schema.db')
  end

  desc 'Reset the database'
  task reset: %i[drop create migrate]
end

namespace :generate do
  desc 'Generate a new migration'
  task :migration do
    name = ARGV[1] || raise('migration name is required')
    Tasks::MigrationGenerator.new(name).generate
    puts 'Migration created'

    abort # stop from running task for migration name
  end
end
