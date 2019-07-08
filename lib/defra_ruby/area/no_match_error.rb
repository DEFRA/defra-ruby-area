# frozen_string_literal: true

module DefraRuby
  module Area
    class NoMatchError < StandardError
      def initialize
        super("No match found")
      end
    end
  end
end
