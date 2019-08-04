# frozen_string_literal: true

require "spec_helper"

module DefraRuby
  module Area
    RSpec.describe Configuration do
      it "sets the appropriate default config settings" do
        fresh_config = described_class.new

        expect(fresh_config.timeout).to eq(3)
      end
    end
  end
end
