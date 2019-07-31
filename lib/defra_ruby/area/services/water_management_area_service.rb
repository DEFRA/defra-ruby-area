# frozen_string_literal: true

require "nokogiri"
require "rest-client"

module DefraRuby
  module Area
    class WaterManagementAreaService < BaseAreaService

      private

      def response_xml_path
        type_name = "Administrative_Boundaries_Water_Management_Areas"
        "//wfs:FeatureCollection/gml:featureMember/ms:#{type_name}/ms:long_name"
      end

      def url
        # rubocop:disable Metrics/LineLength
        "https://environment.data.gov.uk/spatialdata/administrative-boundaries-water-management-areas/wfs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&typeNames=ms:Administrative_Boundaries_Water_Management_Areas&propertyName=long_name&SRSName=EPSG:27700&Filter=(<Filter><Intersects><PropertyName>SHAPE</PropertyName><gml:Point><gml:coordinates>#{easting},#{northing}</gml:coordinates></gml:Point></Intersects></Filter>)"
        # rubocop:enable Metrics/LineLength
      end

    end
  end
end
