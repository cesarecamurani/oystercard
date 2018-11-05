require "oystercard"

describe Oystercard do

  it { expect(subject.balance).to eq 0 }

  describe "#top_up" do
    it "increase the balance" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
    it "raise an error if the limit is reached" do
      expect{ subject.top_up(100) }.to raise_error "Max limit is £90"
    end
  end

  describe "#deduct" do
    it "deduct the amount from the balance" do
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end
  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in) }
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out) }
  end

  describe "#in_journey" do
    it { is_expected.to respond_to(:in_journey) }
  end

end
