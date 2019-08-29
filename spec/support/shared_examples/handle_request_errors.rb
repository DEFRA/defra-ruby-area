# frozen_string_literal: true

RSpec.shared_examples "handle request errors" do
  context "when there is a problem with the Web Feature Service" do
    before(:each) { VCR.turn_off! }
    after(:each) { VCR.turn_on! }

    let(:host) { "https://environment.data.gov.uk/" }
    let(:easting) { 408_602.61 }
    let(:northing) { 257_535.31 }

    context "and the request times out" do
      before(:each) { stub_request(:any, /.*#{host}.*/).to_timeout }

      it "returns a failed response" do
        response = described_class.run(easting, northing)
        expect(response).to be_a(DefraRuby::Area::Response)
        expect(response).to_not be_successful
        expect(response.areas).to be_empty
        expect(response.error).to_not be_nil
      end
    end

    context "and the request returns an error" do
      before(:each) { stub_request(:any, /.*#{host}.*/).to_raise(SocketError) }

      it "returns a failed response" do
        response = described_class.run(easting, northing)
        expect(response).to be_a(DefraRuby::Area::Response)
        expect(response).to_not be_successful
        expect(response.areas).to be_empty
        expect(response.error).to_not be_nil
      end
    end
  end
end
