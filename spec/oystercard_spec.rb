require "oystercard"

describe Oystercard do

  it { expect(subject.balance).to eq 0 }

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it { expect{ subject.top_up 1 }.to change{ subject.balance }.by 1 }
  end

  it "raise an error if balance exceed the limit of £90" do
    expect { subject.top_up(100) }.to raise_error "Max limit is £90"
  end



end
