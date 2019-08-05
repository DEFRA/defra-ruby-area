# frozen_string_literal: true

require "nokogiri"
require "rest-client"

module DefraRuby
  module Area
    class BaseAreaService

      def self.run(easting, northing)
        new(easting, northing).run
      end

      def initialize(easting, northing)
        @easting = easting
        @northing = northing
      end

      def run
        Response.new(response_exe)
      end

      private

      attr_reader :easting, :northing

      def response_exe
        lambda do
          response = RestClient::Request.execute(
            method: :get,
            url: url,
            timeout: DefraRuby::Area.configuration.timeout
          )
          area = parse_xml(response)
          raise NoMatchError if area.nil? || area == ""

          { area: area }
        end
      end

      def parse_xml(response)
        xml = Nokogiri::XML(response)
        xml.xpath(response_xml_path).text
      end

      def response_xml_path
        "//wfs:FeatureCollection/gml:featureMember/ms:#{type_name}/ms:long_name"
      end

      def url
        implemented_in_subclass
      end

      def domain
        "https://environment.data.gov.uk"
      end

      def type_name
        implemented_in_subclass
      end

      def implemented_in_subclass
        raise NotImplementedError, "This #{self.class} cannot respond to:"
      end
    end
  end
end
