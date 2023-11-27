# frozen_string_literal: true

require "spec_helper"

module DefraRuby
  module Area
    RSpec.describe Response do
      subject(:response) { described_class.new(response_exe) }

      let(:valid_xml) do
        document = Nokogiri::XML(File.read("spec/fixtures/water_management_area_valid.xml"))
        document.xpath("//wfs:FeatureCollection/gml:featureMember").first.first_element_child
      end

      let(:successful) { -> { { areas: [Area.new(valid_xml)] } } }
      let(:errored) { -> { raise "Boom!" } }

      describe "#successful?" do
        context "when the response throws an error" do
          let(:response_exe) { errored }

          it "returns false" do
            expect(response).not_to be_successful
          end
        end

        context "when the response doesn't throw an error" do
          let(:response_exe) { successful }

          it "returns true" do
            expect(response).to be_successful
          end
        end
      end

      describe "#area" do
        context "when the response throws an error" do
          let(:response_exe) { errored }

          it "returns nothing" do
            expect(response.areas).to be_empty
          end
        end

        context "when the response does not throw an error" do
          let(:response_exe) { successful }

          it "returns an instance of Area" do
            expect(response.areas[0]).to be_instance_of(Area)
          end

          it "returns an area name" do
            expect(response.areas[0].short_name).to eq("Gtr Mancs Mersey and Ches")
          end
        end
      end

      describe "#error" do
        context "when the response throws an error" do
          let(:response_exe) { errored }

          it "returns the error" do
            expect(response.error).to be_a(StandardError)
          end
        end

        context "when the response don't throw an error" do
          let(:response_exe) { successful }

          it "returns a nil object" do
            expect(response.error).to be_nil
          end
        end
      end
    end
  end
end
