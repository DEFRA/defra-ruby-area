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
        @area_id = @xml.xpath("*[local-name()='identifier']").text.to_i
        @code = @xml.xpath("*[local-name()='code']").text
        @long_name = @xml.xpath("*[local-name()='long_name']").text
        @short_name = @xml.xpath("*[local-name()='short_name']").text
        @area_name = @long_name
      end

    end
  end
end
