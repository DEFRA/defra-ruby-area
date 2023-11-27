# frozen_string_literal: true

require "spec_helper"
require "nokogiri"

module DefraRuby
  module Area
    RSpec.describe Area do
      let(:valid_xml) do
        document = Nokogiri::XML(File.read("spec/fixtures/water_management_area_valid.xml"))
        document.xpath("//wfs:FeatureCollection/gml:featureMember").first.first_element_child
      end
      let(:invalid_xml) { "foo" }

      describe "#initialize" do
        context "when `wfs_xml_element` is missing" do
          it "raises an ArgumentError" do
            expect { described_class.new(nil) }.to raise_error(ArgumentError, "wfs_xml_element is invalid")
          end
        end

        context "when `wfs_xml_element` is invalid" do
          it "raises an error" do
            expect { described_class.new(invalid_xml) }.to raise_error(ArgumentError, "wfs_xml_element is invalid")
          end
        end

        context "when `wfs_xml_element` is valid" do
          subject(:area) { described_class.new(valid_xml) }

          it "populates area_id" do
            expect(area.area_id).to eq(12)
          end

          it "populates area_name" do
            expect(area.area_name).to eq("Greater Manchester Merseyside and Cheshire")
          end

          it "populates code" do
            expect(area.code).to eq("GMC")
          end

          it "populates short_name" do
            expect(area.short_name).to eq("Gtr Mancs Mersey and Ches")
          end

          it "populates long_name" do
            expect(area.long_name).to eq("Greater Manchester Merseyside and Cheshire")
          end
        end
      end

    end
  end
end
