# frozen_string_literal: true

require "spec_helper"
require "nokogiri"

module DefraRuby
  module Area
    RSpec.describe Area do
      let(:valid_area) do
        json = JSON.parse(File.read("spec/fixtures/water_management_area_valid.json"))
        json["features"].first
      end
      let(:invalid_area) { "foo" }

      describe "#initialize" do
        context "when `area_record` is missing" do
          it "raises an ArgumentError" do
            expect { described_class.new(nil) }.to raise_error(ArgumentError, "area_record is invalid")
          end
        end

        context "when `area_record` is invalid" do
          it "raises an error" do
            expect { described_class.new(invalid_area) }.to raise_error(ArgumentError, "area_record is invalid")
          end
        end

        context "when `wfs_xml_element` is valid" do
          subject(:area) { described_class.new(valid_area) }

          it "populates area_id" do
            expect(area.area_id).to eq(31)
          end

          it "populates area_name" do
            expect(area.area_name).to eq("Shropshire Herefordshire Worcestershire and Gloucestershire")
          end

          it "populates code" do
            expect(area.code).to eq("SHHRWG")
          end

          it "populates short_name" do
            expect(area.short_name).to eq("Shrops Heref Worcs and Glos")
          end

          it "populates long_name" do
            expect(area.long_name).to eq("Shropshire Herefordshire Worcestershire and Gloucestershire")
          end
        end
      end

    end
  end
end
