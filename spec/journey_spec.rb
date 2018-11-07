require 'journey'

describe Journey do
  let(:journey){ described_class.new }
  let(:station){ double :station}
  let(:oystercard){ double :oystercard }

  it { expect(journey.moving).to eq false }
  it { expect(journey.journey_log).to be_empty }

  describe "#start_journey" do
    it "tracks the entry station" do
      expect{ journey.start_journey(station) }.to change{ journey.moving }.to true
      expect(journey.current_journey[:entry]).to eq station
    end
  end

  describe "#end_journey" do
    it "tracks the exit station" do
      journey.start_journey(station)
      expect{ journey.end_journey(station) }.to change{ journey.moving }.to false
      expect(journey.current_journey[:exit]).to eq station
    end
  end

  describe "#charge_fare" do
    it "deducts the fare for the journey from the balance" do
      allow(oystercard).to receive(:top_up) {10}
      journey.start_journey(station)
      journey.end_journey(station)
    end
  end
end
