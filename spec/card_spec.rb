require 'card.rb'

describe Oystercard do

  subject(:card) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  # let(:journey) { double :journey }
  let(:journey){ Journey.new(entry_station) }

  describe "#initialization" do

    it 'starts with a balance of 0' do
      expect(card.balance).to eq 0
    end

  end

  it { is_expected.to respond_to(:touch_in).with(1).argument }

  it { is_expected.to respond_to(:touch_out).with(1).argument }

  describe "#top_up" do

    it "should test that balance will change due to amount added" do
      expect{ card.top_up 10 }.to change{ card.balance }.by 10
    end

    it "should raise error if balance is more than 90" do
      maximum_top_up = described_class::MAXIMUM_BALANCE
      card.top_up(maximum_top_up)
      expect{card.top_up(100)}.to raise_error("Cannot top up: balance capacity of #{maximum_top_up} has been exceeded")
    end

  end

  describe "#touch_in" do

    it "should raise error if balance is below 1 pound" do
      expect{card.touch_in(entry_station)}.to raise_error("Cannot touch in: not enough funds")
    end

  end


  context 'card is topped up' do

    before do
      card.top_up(described_class::MAXIMUM_BALANCE)
      card.touch_in(entry_station)
    end

    describe "#touch_in" do

      it "should has entry_station" do
        card.touch_in(entry_station)
        expect(journey.entry_station).to eq entry_station
      end

    end

    describe "#touch_out" do

      it "should test that minimum value is deducted from card at touch out" do
        expect{ card.touch_out(exit_station) }.to change{ card.balance }.by(-described_class::MINIMUM_BALANCE)
      end

    end

  end

end
