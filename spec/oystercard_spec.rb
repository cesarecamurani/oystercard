require "oystercard"

describe Oystercard do
  let(:oystercard){ described_class.new }
  let(:station){ double :station }
  let(:journey){ double :journey }

  it { expect(oystercard.balance).to eq 0 }

  describe "#top_up" do
    it "increase the balance" do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end
    it "raise an error if the limit of £90 is reached" do
      expect{ oystercard.top_up(100) }.to raise_error "Max limit is £90"
    end
  end

  it "raise an error on touch in if the balance is less than £1" do
    expect{ oystercard.touch_in(station) }.to raise_error "Not enough credit"
  end
  
end
