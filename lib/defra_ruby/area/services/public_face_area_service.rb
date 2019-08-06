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
        "ms:Administrative_Boundaries_Environment_Agency_and_Natural_England_Public_Face_Areas"
      end

    end
  end
end
