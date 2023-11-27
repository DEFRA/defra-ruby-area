# frozen_string_literal: true

require "webmock/rspec"
require "spec_helper"

module DefraRuby
  module Area
    RSpec.describe WaterManagementAreaService do
      let(:host) { "https://environment.data.gov.uk" }

      describe "#run" do
        context "when the coordinates are valid and in England" do
          before do
            stub_request(:any, /.*#{host}.*/).to_return(
              status: 200,
              body: File.read("./spec/fixtures/water_management_area_valid.xml")
            )
          end

          let(:easting) { 408_602.61 }
          let(:northing) { 257_535.31 }

          subject(:response) { described_class.run(easting, northing) }
          include_examples "successful response", "Greater Manchester Merseyside and Cheshire"
        end

        context "when the coordinates are valid, in England but match more than one area" do
          before do
            stub_request(:any, /.*#{host}.*/).to_return(
              status: 200,
              body: File.read("./spec/fixtures/water_management_area_valid_multiple.xml")
            )
          end

          let(:easting) { 456_330 }
          let(:northing) { 267_000 }

          include_examples "successful response", "Lincolnshire and Northamptonshire"
        end

        context "when the coordinates are invalid" do
          context "when they are blank" do
            before do
              stub_request(:any, /.*#{host}.*/).to_return(
                status: 200,
                body: File.read("./spec/fixtures/water_management_area_invalid_blank.xml")
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
                body: File.read("./spec/fixtures/water_management_area_invalid_coords.xml")
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
