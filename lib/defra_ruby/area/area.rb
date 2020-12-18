# frozen_string_literal: true

require "nokogiri"

module DefraRuby
  module Area
    class Area
      attr_reader :area_id, :area_name, :code, :long_name, :short_name

      def initialize(wfs_xml_element)
        @xml = wfs_xml_element

        validate_xml
        parse_xml
      end

      private

      def validate_xml
        raise(ArgumentError, "wfs_xml_element is invalid") unless @xml.is_a?(Nokogiri::XML::Element)
      end

      def parse_xml
        @area_id = @xml.xpath("ms:area_id").text.to_i
        @area_name = @xml.xpath("ms:area_name").text
        @code = @xml.xpath("ms:code").text
        @long_name = @xml.xpath("ms:long_name").text
        @short_name = @xml.xpath("ms:short_name").text
      end

    end
  end
end
