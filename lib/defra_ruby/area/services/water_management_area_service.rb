# frozen_string_literal: true

require "nokogiri"
require "rest-client"

module DefraRuby
  module Area
    class WaterManagementAreaService < BaseAreaService

      private

      def dataset
        "administrative-boundaries-water-management-areas"
      end

      def type_name
        "ms:Administrative_Boundaries_Water_Management_Areas"
      end

    end
  end
end
