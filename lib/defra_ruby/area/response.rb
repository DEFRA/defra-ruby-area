# frozen_string_literal: true

module DefraRuby
  module Area
    class Response
      attr_reader :error
      attr_reader :areas

      def initialize(response_exe)
        @success = true
        @areas = []
        @error = nil

        capture_response(response_exe)
      end

      def successful?
        success
      end

      private

      attr_reader :success

      def capture_response(response_exe)
        @areas = response_exe.call[:areas]
      rescue StandardError => e
        @error = e
        @success = false
      end
    end
  end
end
