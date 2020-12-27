# frozen_string_literal: true

require 'active_record'
require 'active_record/schema_dumper'

module Tasks
  # Database
  class Database
    class << self
      def establish_connection(config)
        ActiveRecord::Base.establish_connection(config)
      end

      def create_database!
        ActiveRecord::Base.connection.exec_query('SELECT 1+1')
      end

      def migrate!(config)
        establish_connection(config)
        context.migrate
      end

      def dump_schema(config, filename)
        establish_connection(config)

        File.open(filename, 'w:utf-8') do |file|
          ActiveRecord::SchemaDumper.dump(connection, file)
        end
      end

      private

      def connection
        ActiveRecord::Base.connection
      end

      def context
        schema_migration = ActiveRecord::SchemaMigration

        ActiveRecord::MigrationContext.new(migrations_paths, schema_migration)
      end

      def migrations_paths
        ActiveRecord::Migrator.migrations_paths
      end
    end
  end
end
