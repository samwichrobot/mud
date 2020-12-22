# frozen_string_literal: true

require 'yaml'

module Tasks
  # Configuration
  class Configuration
    def self.current_env
      ENV['MUD_ENV'] || 'development'
    end

    def self.get_config(env = current_env)
      db_config = YAML.safe_load(File.open('config/database.yml'))
      db_config[env]
    end

    def self.get_database_path(env = current_env)
      get_config(env)['database']
    end
  end
end
