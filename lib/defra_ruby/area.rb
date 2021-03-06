# frozen_string_literal: true

require_relative "area/configuration"
require_relative "area/no_match_error"
require_relative "area/response"
require_relative "area/area"

require_relative "area/services/base_area_service"
require_relative "area/services/public_face_area_service"
require_relative "area/services/water_management_area_service"

module DefraRuby
  module Area
    class << self
      # attr_accessor :configuration

      def configure
        yield(configuration)
      end

      def configuration
        @configuration ||= Configuration.new
        @configuration
      end
    end
  end
end
