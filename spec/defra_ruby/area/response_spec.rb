# frozen_string_literal: true

require "spec_helper"

module DefraRuby
  module Area
    RSpec.describe Response do
      subject(:response) { described_class.new(response_exe) }

      let(:valid_type_name) { "ms:Administrative_Boundaries_Water_Management_Areas" }
      let(:valid_xml) { File.open("spec/fixtures/valid.xml") { |f| Nokogiri::XML(f) } }

      let(:successful) { -> { { area: Area.new(valid_type_name, valid_xml) } } }
      let(:errored) { -> { raise "Boom!" } }

      describe "#successful?" do
        context "when the response throws an error" do
          let(:response_exe) { errored }

          it "returns false" do
            expect(response).to_not be_successful
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
            expect(response.area).to be_nil
          end
        end

        context "when the response does not throw an error" do
          let(:response_exe) { successful }

          it "returns an area" do
            expect(response.area).to be_instance_of(Area)
            expect(response.area.short_name).to eq("Staffs Warks and West Mids")
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
