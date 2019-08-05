# frozen_string_literal: true

require "nokogiri"
require "rest-client"

module DefraRuby
  module Area
    class PublicFaceAreaService < BaseAreaService

      private

      def dataset
        "administrative-boundaries-environment-agency-and-natural-england-public-face-areas"
      end

      def type_name
        "Administrative_Boundaries_Environment_Agency_and_Natural_England_Public_Face_Areas"
      end

      def url
        # rubocop:disable Metrics/LineLength
        "#{domain}/spatialdata/#{dataset}/wfs?#{service}&VERSION=1.0.0&#{operation}&typeNames=ms:#{type_name}&propertyName=long_name&SRSName=EPSG:27700&Filter=(<Filter><Intersects><PropertyName>SHAPE</PropertyName><gml:Point><gml:coordinates>#{easting},#{northing}</gml:coordinates></gml:Point></Intersects></Filter>)"
        # rubocop:enable Metrics/LineLength
      end

    end
  end
end
