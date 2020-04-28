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
          it "populates all an Area's attributes" do
            subject = described_class.new(valid_xml)

            expect(subject.area_id).to eq(29)
            expect(subject.area_name).to eq("Central")
            expect(subject.code).to eq("STWKWM")
            expect(subject.short_name).to eq("Staffs Warks and West Mids")
            expect(subject.long_name).to eq("Staffordshire Warwickshire and West Midlands")
          end
        end
      end

    end
  end
end
