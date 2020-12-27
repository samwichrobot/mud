# frozen_string_literal: true

module Tasks
  # MigrationNameGenerator
  class MigrationNameGenerator
    def self.generate(name)
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')

      "#{timestamp}_#{name}.rb"
    end
  end
end
