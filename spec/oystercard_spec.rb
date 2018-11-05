require "oystercard"

describe Oystercard do
  let(:oystercard) { described_class.new }

  it { expect(oystercard.balance).to eq 5 }
  it { expect(oystercard.moving).to eq false }

  describe "#top_up" do
    it "increase the balance" do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end
    it "raise an error if the limit is reached" do
      expect{ oystercard.top_up(100) }.to raise_error "Max limit is £90"
    end
  end

  describe "#deduct" do
    it "deduct the amount from the balance" do
      expect{ oystercard.deduct 1 }.to change{ oystercard.balance }.by -1
    end
  end

  describe "#touch_in" do
    it "allow the passenger to enter the tube" do
      expect{ oystercard.touch_in(1) }.to change{ oystercard.moving }.to true
    end
    it "raise an error if the credit is less than £1" do
      expect{ oystercard.touch_in(0) }.to raise_error "Not enough credit"
    end
  end

  describe "#touch_out" do
    it "allow the passenger to leave the tube" do
      oystercard.touch_in(1)
      expect{ oystercard.touch_out }.to change{ oystercard.moving }.to false
    end
  end


  end
