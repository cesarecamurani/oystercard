require 'journey'

describe Journey do
  subject(:journey){ described_class.new }
  let(:station){ double :station }
  let(:oystercard){ double :oystercard }

  it { expect(journey.in_journey).to eq false }

  describe "#start_journey" do
    it "sets in_journey to true" do
      expect{ journey.start_journey }.to change{ journey.in_journey }.to true
    end
  end

  describe "#end_journey" do
    it "sets in_journey to false" do
      journey.start_journey
      expect{ journey.end_journey }.to change{ journey.in_journey }.to false
    end
  end


end
