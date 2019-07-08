# frozen_string_literal: true

module DefraRuby
  module Area
    class Response
      attr_reader :error
      attr_reader :area

      def initialize(response_exe)
        @success = true
        @area = nil
        @error = nil

        capture_response(response_exe)
      end

      def successful?
        success
      end

      private

      attr_reader :success

      def capture_response(response_exe)
        @area = response_exe.call[:area]
      rescue StandardError => e
        @error = e
        @success = false
      end
    end
  end
end
