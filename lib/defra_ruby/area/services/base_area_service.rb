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

      def dataset
        implemented_in_subclass
      end

      # There are generally 3 kinds of GIS services; WFS, WMS, and WCS.
      #
      # * WFS - allows features to be queried, updated, created, or deleted by the client
      # * WMS - returns map images based on the request made
      # * WCS - transfer "coverages", ie. objects covering a geographical area
      #
      # We are querying a 'feature' hence we request to use the WFS service.
      #
      # N.B. A feature is an Object that is an abstraction of a real world
      # phenomenon. This object has a set of properties associated with each
      # having a name, a type, and a value.
      def service
        "SERVICE=WFS"
      end

      # Used to tell the WFS what function you wish it to perform. In the case
      # of `GetFeature` this means
      #
      #   Returns a selection of features from a data source including geometry and attribute values
      #
      # https://docs.geoserver.org/latest/en/user/services/wfs/reference.html#getfeature
      def operation
        "REQUEST=GetFeature"
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
