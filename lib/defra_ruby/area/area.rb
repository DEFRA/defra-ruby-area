# frozen_string_literal: true

module DefraRuby
  module Area
    class Area
      attr_reader :area_id, :code, :long_name, :short_name

      def initialize(area_id, code, long_name, short_name)
        @area_id = area_id
        @code = code
        @long_name = long_name
        @short_name = short_name
      end

      def matched?
        "#{@area_id}#{@code}#{@long_name}#{@short_name}" != ""
      end

    end
  end
end
