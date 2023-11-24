# frozen_string_literal: true

require "spec_helper"

RSpec.describe DefraRuby::Area do
  describe "VERSION" do
    it "is a version string" do
      expect(DefraRuby::Area::VERSION).to be_a(String)
    end

    it "in the correct format" do
      expect(DefraRuby::Area::VERSION).to match(/\d+\.\d+\.\d+/)
    end
  end

  describe "#configuration" do
    context "when the host app has not provided configuration" do
      it "returns a DefraRuby::Area::Configuration instance" do
        expect(described_class.configuration).to be_an_instance_of(DefraRuby::Area::Configuration)
      end
    end

    context "when the host app has provided configuration" do
      let(:timeout) { 10 }

      it "returns an DefraRuby::Area::Configuration instance with a matching timeout" do
        described_class.configure { |config| config.timeout = timeout }

        expect(described_class.configuration.timeout).to eq(timeout)
      end
    end
  end
end
