# frozen_string_literal: true

require "spec_helper"

module DefraRuby
  module Area
    RSpec.describe PublicFaceAreaService do
      describe "#run" do

        context "when the coordinates are valid and in England" do
          before(:each) { VCR.insert_cassette("public_face_area_valid") }
          after(:each) { VCR.eject_cassette }

          let(:easting) { 408_602.61 }
          let(:northing) { 257_535.31 }

          it "returns a successful response" do
            response = described_class.run(easting, northing)
            expect(response).to be_a(Response)
            expect(response.successful?).to eq(true)
            expect(response.area).to eq("West Midlands")
          end

        end

        context "when the coordinates are invalid" do
          context "because they are blank" do
            before(:each) { VCR.insert_cassette("public_face_area_invalid_blank") }
            after(:each) { VCR.eject_cassette }

            let(:easting) { nil }
            let(:northing) { nil }

            it "returns a failed response" do
              response = described_class.run(easting, northing)
              expect(response).to be_a(Response)
              expect(response).to_not be_successful
              expect(response.area).to be_nil
              expect(response.error).to_not be_nil
            end
          end

          context "because they are not in an area" do
            before(:each) { VCR.insert_cassette("public_face_area_invalid_coords") }
            after(:each) { VCR.eject_cassette }

            let(:easting) { 301_233.0 }
            let(:northing) { 221_592.0 }

            it "returns a failed response" do
              response = described_class.run(easting, northing)
              expect(response).to be_a(Response)
              expect(response).to_not be_successful
              expect(response.area).to be_nil
              expect(response.error).to_not be_nil
            end
          end

        end

        context "when there is a problem with the Web Feature Service" do
          before(:each) { VCR.turn_off! }
          after(:each) { VCR.turn_on! }

          let(:host) { "https://environment.data.gov.uk/" }
          let(:easting) { 408_602.61 }
          let(:northing) { 257_535.31 }

          context "and the request times out" do
            before(:each) { stub_request(:any, /.*#{host}.*/).to_timeout }

            it "returns a failed response" do
              response = described_class.run(easting, northing)
              expect(response).to be_a(Response)
              expect(response).to_not be_successful
              expect(response.area).to be_nil
              expect(response.error).to_not be_nil
            end
          end

          context "and request returns an error" do
            before(:each) { stub_request(:any, /.*#{host}.*/).to_raise(SocketError) }

            it "returns a failed response" do
              response = described_class.run(easting, northing)
              expect(response).to be_a(Response)
              expect(response).to_not be_successful
              expect(response.area).to be_nil
              expect(response.error).to_not be_nil
            end
          end

        end
      end
    end
  end
end
