require "oystercard"

describe Oystercard do
  let(:oystercard){ described_class.new }
  let(:station){ double :station }

  it { expect(oystercard.balance).to eq 0 }
  it { expect(oystercard.moving).to eq false }
  it { expect(oystercard.history).to be_empty }

  describe "#top_up" do
    it "increase the balance" do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end
    it "raise an error if the limit is reached" do
      expect{ oystercard.top_up(100) }.to raise_error "Max limit is £90"
    end
  end

  describe "#touch_in" do
    it "allow the passenger to enter the tube" do
      oystercard.top_up(1)
      expect{ oystercard.touch_in(station) }.to change{ oystercard.moving }.to true
    end
    it "track the entry station" do
      oystercard.top_up(1)
      oystercard.touch_in(station)
      expect(oystercard.history[:entry]).to eq station
    end
    it "raise an error if the credit is less than £1" do
      expect{ oystercard.touch_in(station) }.to raise_error "Not enough credit"
    end
  end

  describe "#touch_out" do
    it "allow the passenger to leave the tube" do
      oystercard.top_up(1)
      oystercard.touch_in(station)
      expect{ oystercard.touch_out(station) }.to change{ oystercard.moving }.to false
      expect{ oystercard.touch_out(station) }.to change{ oystercard.balance }.by(-Oystercard::MIN_FARE)
      expect(oystercard.history[:exit]).to eq station
    end
  end


  end
