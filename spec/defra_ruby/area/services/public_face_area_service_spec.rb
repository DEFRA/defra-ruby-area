# frozen_string_literal: true

require "webmock/rspec"
require "spec_helper"

module DefraRuby
  module Area
    RSpec.describe PublicFaceAreaService do
      let(:host) { "https://environment.data.gov.uk" }

      describe "#run" do
        context "when the coordinates are valid and in England" do
          before do
            stub_request(:any, /.*#{host}.*/).to_return(
              status: 200,
              body: File.read("./spec/fixtures/public_face_area_valid.json")
            )
          end

          let(:easting) { 408_602.61 }
          let(:northing) { 257_535.31 }

          include_examples "successful response", "West Midlands"
        end

        context "when the coordinates are valid, in England but match more than one area" do
          before do
            stub_request(:any, /.*#{host}.*/).to_return(
              status: 200,
              body: File.read("./spec/fixtures/public_face_area_valid_multiple.json")
            )
          end

          let(:easting) { 398_056.684 }
          let(:northing) { 414_748 }

          include_examples "successful response", "Yorkshire"
        end

        context "when the coordinates are invalid" do
          context "when they are blank" do
            before do
              stub_request(:any, /.*#{host}.*/).to_return(
                status: 200,
                body: File.read("./spec/fixtures/public_face_area_invalid_blank.xml")
              )
            end

            let(:easting) { nil }
            let(:northing) { nil }

            include_examples "failed response"
          end

          context "when they are not in an area" do
            before do
              stub_request(:any, /.*#{host}.*/).to_return(
                status: 200,
                body: File.read("./spec/fixtures/public_face_area_invalid_coords.json")
              )
            end

            let(:easting) { 301_233.0 }
            let(:northing) { 221_592.0 }

            include_examples "failed response"
          end

        end

        include_examples "handle request errors"
      end
    end
  end
end
