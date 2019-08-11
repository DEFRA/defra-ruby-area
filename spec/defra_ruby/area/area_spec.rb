# frozen_string_literal: true

require "spec_helper"
require "nokogiri"

module DefraRuby
  module Area
    RSpec.describe Area do
      let(:valid_type_name) { "ms:Administrative_Boundaries_Water_Management_Areas" }
      let(:invalid_type_name) { "////" }
      let(:no_match_type_name) { "ms:Marvel_Cinematic_Universe_Areas" }

      let(:valid_xml) { File.open("spec/fixtures/valid.xml") { |f| Nokogiri::XML(f) } }
      let(:invalid_xml) { "foo" }
      let(:no_match_xml) { File.open("spec/fixtures/no_match.xml") { |f| Nokogiri::XML(f) } }

      let(:no_match_area) { described_class.new(valid_type_name, no_match_xml) }
      let(:matched_area) { described_class.new(valid_type_name, valid_xml) }

      describe "#initialize" do
        context "when arguments are missing" do

          context "and both arguments are missing" do
            it "raises an ArgumentError" do
              expect { described_class.new(nil, nil) }.to raise_error(ArgumentError, "type_name is invalid")
            end
          end

          context "and `type_name` is missing" do
            it "raises an ArgumentError" do
              expect { described_class.new(nil, valid_xml) }.to raise_error(ArgumentError, "type_name is invalid")
            end
          end

          context "and `wfs_xml_response` is missing" do
            it "raises an ArgumentError" do
              expect { described_class.new(valid_type_name, nil) }.to raise_error(ArgumentError, "wfs_xml_response is invalid")
            end
          end
        end

        context "when arguments are invalid" do

          context "and passed an invalid Nokogiri::XML::Documentation instance" do
            it "raises an error" do
              expect { described_class.new(valid_type_name, invalid_xml) }.to raise_error(ArgumentError, "wfs_xml_response is invalid")
            end
          end

          context "and passed an invalid type name" do
            it "raises an error" do
              expect { described_class.new(invalid_type_name, valid_xml) }.to raise_error(Nokogiri::XML::XPath::SyntaxError)
            end
          end
        end

        context "when passed valid arguments" do

          context "and type name is recognised and there was a match" do
            it "populates all an Area's attributes" do
              subject = described_class.new(valid_type_name, valid_xml)

              expect(subject.area_id).to eq(29)
              expect(subject.area_name).to eq("Central")
              expect(subject.code).to eq("STWKWM")
              expect(subject.short_name).to eq("Staffs Warks and West Mids")
              expect(subject.long_name).to eq("Staffordshire Warwickshire and West Midlands")
            end
          end

          context "and type name does not match the xml" do
            it "does not populate an Area's attributes" do
              subject = described_class.new(no_match_type_name, valid_xml)

              expect(subject.area_id).to eq(0)
              expect(subject.area_name).to eq("")
              expect(subject.code).to eq("")
              expect(subject.short_name).to eq("")
              expect(subject.long_name).to eq("")
            end
          end

          context "and the WFS responded with no match" do
            it "does not populate an Area's attributes" do
              subject = described_class.new(valid_type_name, no_match_xml)

              expect(subject.area_id).to eq(0)
              expect(subject.area_name).to eq("")
              expect(subject.code).to eq("")
              expect(subject.short_name).to eq("")
              expect(subject.long_name).to eq("")
            end
          end
        end
      end

      describe "#matched?" do
        context "when no match was found" do

          it "returns false" do
            expect(no_match_area.matched?).to eq(false)
          end
        end

        context "when a match was found" do

          it "returns true" do
            expect(matched_area.matched?).to eq(true)
          end
        end
      end
    end
  end
end
