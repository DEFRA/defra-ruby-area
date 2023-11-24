# frozen_string_literal: true

RSpec.shared_examples "handle request errors" do
  context "when there is a problem with the Web Feature Service" do
    let(:easting) { 408_602.61 }
    let(:northing) { 257_535.31 }

    context "when the request times out" do
      subject(:response) { described_class.run(easting, northing) }

      before { stub_request(:any, /.*#{host}.*/).to_timeout }

      include_examples "failed response"
    end

    context "when the request returns an error" do
      subject(:response) { described_class.run(easting, northing) }

      before { stub_request(:any, /.*#{host}.*/).to_raise(SocketError) }

      include_examples "failed response"
    end
  end
end
