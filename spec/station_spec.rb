require 'station'

describe Station do
  let(:station) {described_class.new("Kings Cross", 2)}
  it "should have a name" do
    expect(station).to respond_to :name
  end
  it "should have a zone" do
    expect(station.zone).to eq 2
  end
end
