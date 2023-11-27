# frozen_string_literal: true

RSpec.shared_examples "failed response" do
  subject(:response) { described_class.run(easting, northing) }

  it "returns a Response type object" do
    expect(response).to be_a(DefraRuby::Area::Response)
  end

  it "returns a failed response" do
    expect(response).not_to be_successful
  end

  it "returns an empty areas property" do
    expect(response.areas).to be_empty
  end

  it "returns an error message" do
    expect(response.error).not_to be_nil
  end
end
