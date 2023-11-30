# frozen_string_literal: true

require "nokogiri"

module DefraRuby
  module Area
    class Area
      attr_reader :area_id, :area_name, :code, :long_name, :short_name

      def initialize(area_record)
        @area_record = area_record

        validate_area_record
        parse_area_record
      end

      private

      def validate_area_record
        unless @area_record && @area_record["properties"]&.keys&.sort == %w[
          code identifier long_name short_name
        ]
          raise(ArgumentError,
                "area_record is invalid")
        end
      end

      def parse_area_record
        @area_id = @area_record["properties"]["identifier"].to_i
        @code = @area_record["properties"]["code"]
        @long_name = @area_record["properties"]["long_name"]
        @short_name = @area_record["properties"]["short_name"]
        # area_name is no longer part of the response, but we're keeping it for backwards compatibility
        @area_name = @long_name
      end

    end
  end
end
