# frozen_string_literal: true

module DefraRuby
  module Area
    class Configuration
      attr_accessor :timeout

      def initialize
        @timeout = 3
      end
    end
  end
end
