require 'station'

describe Station do
  let(:station){ described_class.new("Piccadilly", 1) }

  it "Station has a name" do
    expect(station.name).to eq "Piccadilly"
  end
  it "Station has a zone" do
    expect(station.zone).to eq 1
  end

end
