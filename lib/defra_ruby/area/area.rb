# frozen_string_literal: true

require "nokogiri"

module DefraRuby
  module Area
    class Area
      attr_reader :area_id, :code, :long_name, :short_name

      def initialize(type_name, wfs_xml_response)
        @type_name = type_name
        @xml = wfs_xml_response

        validate
        parse_xml
      end

      def matched?
        "#{@code}#{@long_name}#{@short_name}" != ""
      end

      private

      def validate
        validate_type_name
        validate_xml
      end

      def validate_type_name
        raise(ArgumentError, "type_name is invalid") unless @type_name && @type_name != ""
      end

      def validate_xml
        raise(ArgumentError, "wfs_xml_response is invalid") unless @xml&.is_a?(Nokogiri::XML::Document)
      end

      def parse_xml
        @area_id = @xml.xpath(response_xml_path(:area_id)).text.to_i
        @code = @xml.xpath(response_xml_path(:code)).text
        @long_name = @xml.xpath(response_xml_path(:long_name)).text
        @short_name = @xml.xpath(response_xml_path(:short_name)).text
      end

      # XML path to the value we wish to extract in the WFS query response.
      def response_xml_path(property)
        "//wfs:FeatureCollection/gml:featureMember/#{@type_name}/ms:#{property}"
      end

    end
  end
end
