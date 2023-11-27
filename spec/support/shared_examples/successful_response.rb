# frozen_string_literal: true

RSpec.shared_examples "successful response" do |area_name|
  subject(:response) { described_class.run(easting, northing) }

  it "returns a Response type object" do
    expect(response).to be_a(DefraRuby::Area::Response)
  end

  it "returns a successful response" do
    expect(response).to be_successful
  end

  it "returns an area name" do
    expect(response.areas[0].long_name).to eq(area_name)
  end
end
