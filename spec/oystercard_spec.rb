require "oystercard"

describe Oystercard do
  let(:oystercard){ described_class.new }
  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }

  it { expect(oystercard.balance).to eq 0 }
  it { expect(oystercard.moving).to eq false }
  #it { expect(oystercard.history).to be_empty }

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
      expect{ oystercard.touch_in(entry_station) }.to change{ oystercard.moving }.to true
    end
    it "track the entry station" do
      oystercard.top_up(1)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end
    it "raise an error if the credit is less than £1" do
      expect{ oystercard.touch_in(entry_station) }.to raise_error "Not enough credit"
    end
  end

  describe "#touch_out" do
    it "allow the passenger to leave the tube" do
      oystercard.top_up(1)
      oystercard.touch_in(entry_station)
      expect{ oystercard.touch_out(exit_station) }.to change{ oystercard.moving }.to false
      expect{ oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by(-Oystercard::MIN_FARE)
      expect(oystercard.exit_station).to eq exit_station
    end
  end


  end
