require 'journey'

describe Journey do
  let(:journey){ described_class.new }
  let(:station){ double :station}
  let(:oystercard){ double :oystercard }

  it { expect(journey.in_journey).to eq false }
  it { expect(journey.current_journey).to be_empty }
  it { expect(journey.journey_log).to be_empty }

  describe "#start_journey" do
    it "tracks the entry station" do
      expect{ journey.start_journey(station) }.to change{ journey.in_journey }.to true
      expect(journey.current_journey[:entry]).to eq station
    end
  end

  describe "#end_journey" do
    it "tracks the exit station" do
      journey.start_journey(station)
      expect{ journey.end_journey(station) }.to change{ journey.in_journey }.to false
      expect(journey.current_journey[:exit]).to eq station
    end
  end

  describe "#journey_log" do
    it "add current journey to the journey log" do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.journey_log).to include journey.current_journey
    end
  end


end
