# frozen_string_literal: true

module Tasks
  # MigrationClassGenerator
  class MigrationClassGenerator
    def self.generate(name)
      classname = name.split('_').map(&:capitalize).join

      <<~CONTENTS
        # frozen_string_literal: true
       
        # #{classname}
        class #{classname} < ActiveRecord::Migration[5.1]
          def self.up; end

          def self.down; end
        end
      CONTENTS
    end
  end
end
