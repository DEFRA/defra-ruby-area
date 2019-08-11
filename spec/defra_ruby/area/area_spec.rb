# frozen_string_literal: true

require "spec_helper"

module DefraRuby
  module Area
    RSpec.describe Area do
      describe "#matched?" do
        context "when no attributes are populated" do
          let(:subject) { described_class.new(nil, nil, nil, nil) }

          it "returns false" do
            expect(subject.matched?).to eq(false)
          end
        end
      end

      describe "#matched?" do
        context "when at least one attribute is populated" do
          let(:subject) { described_class.new(nil, "foo", nil, nil) }

          it "returns true" do
            expect(subject.matched?).to eq(true)
          end
        end
      end
    end
  end
end
