require 'journey_log'
describe JourneyLog do
  subject(:journey_log){ described_class.new }
  let(:journey){ double :journey }
  let(:station){ double :station }

  it { expect(journey_log.current_journey).to be_empty }
  it { expect(journey_log.journeys).to be_empty }

  describe "#track_entry" do
    it "tracks the entry station" do
      journey_log.track_entry(station)
      expect(journey_log.current_journey[:entry]).to eq station
    end
  end

  describe "#track_exit" do
    it "tracks the exit station" do
      journey_log.track_entry(station)
      journey_log.track_exit(station)
      expect(journey_log.current_journey[:exit]).to eq station
    end
  end

  describe "#journeys" do
    it "add current journey to the journeys array" do
      journey_log.track_entry(station)
      journey_log.track_exit(station)
      expect(journey_log.journeys).to include journey_log.current_journey
    end
  end


end
