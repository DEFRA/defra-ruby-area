# frozen_string_literal: true

module DefraRuby
  module Area
    class Area
      attr_reader :code, :long_name, :short_name

      def initialize(code, long_name, short_name)
        @code = code
        @long_name = long_name
        @short_name = short_name
      end

      def matched?
        "#{@code}#{@long_name}#{@short_name}" != ""
      end

    end
  end
end
