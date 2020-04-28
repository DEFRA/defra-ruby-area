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

          it "returns a successful response" do
            response = described_class.run(easting, northing)
            expect(response).to be_a(Response)
            expect(response.successful?).to eq(true)
            expect(response.areas[0].long_name).to eq("Staffordshire Warwickshire and West Midlands")
          end

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

          it "returns a successful response" do
            response = described_class.run(easting, northing)
            expect(response).to be_a(Response)
            expect(response.successful?).to eq(true)
            expect(response.areas[0].long_name).to eq("Lincolnshire and Northamptonshire")
          end
        end

        context "when the coordinates are invalid" do
          context "because they are blank" do
            before do
              stub_request(:any, /.*#{host}.*/).to_return(
                status: 200,
                body: File.read("./spec/fixtures/water_management_area_invalid_blank.xml")
              )
            end

            let(:easting) { nil }
            let(:northing) { nil }

            it "returns a failed response" do
              response = described_class.run(easting, northing)
              expect(response).to be_a(Response)
              expect(response).to_not be_successful
              expect(response.areas).to be_empty
              expect(response.error).to_not be_nil
            end
          end

          context "because they are not in an area" do
            before do
              stub_request(:any, /.*#{host}.*/).to_return(
                status: 200,
                body: File.read("./spec/fixtures/water_management_area_invalid_coords.xml")
              )
            end

            let(:easting) { 301_233.0 }
            let(:northing) { 221_592.0 }

            it "returns a failed response" do
              response = described_class.run(easting, northing)
              expect(response).to be_a(Response)
              expect(response).to_not be_successful
              expect(response.areas).to be_empty
              expect(response.error).to_not be_nil
            end
          end

        end

        include_examples "handle request errors"
      end
    end
  end
end
