require 'oystercard'

describe OysterCard do
  subject(:oystercard) {described_class.new}
  let(:station) {double :station}
  PENALTY_FARE = 6
  top_up_amount = 20
  less_than_min_amount = 0.9
  more_than_max_amount = 91

  it "should check that it has an empty list of journeys by default" do
    expect(oystercard.journey_log).to be_empty
  end

  context "balance" do
    it { is_expected.to respond_to(:balance) }
  end

  context "insufficient funds" do

    before do
      oystercard.top_up(less_than_min_amount)
    end

    it "should raise an error if the balance is less than £#{OysterCard::MINIMUM_FARE}" do
      expect{ oystercard.touch_in(station) }.to raise_error("Insufficient funds. You need to top up.")
    end

  end

  context "sufficient funds" do

    before do
      oystercard.top_up(top_up_amount)
      oystercard.touch_in(station)
    end

    it "deducts minimum fare of £#{OysterCard::MINIMUM_FARE} when touching out" do
      expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-OysterCard::MINIMUM_FARE)
    end
    it "deducts penalty fare of £#{PENALTY_FARE} when touching in twice" do
      expect{oystercard.touch_in(station)}.to change{oystercard.balance}.by(-PENALTY_FARE)
    end

  end

  describe "#top_up" do

    it { is_expected.to respond_to(:top_up).with(1).argument }
    it "should increase the balance by top_up value" do
      oystercard.top_up(top_up_amount)
      expect(oystercard.balance).to eq top_up_amount
    end
    it "should raise an error if max. limit is exceeeded" do
      message = "Cannot top up: £#{OysterCard::MAXIMUM_LIMIT} limit would be exceeded"
      expect {oystercard.top_up(more_than_max_amount)}.to raise_error(message)
    end

  end

  describe "#touching out" do

    before do
      oystercard.top_up(top_up_amount)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
    end

    it "stores the entry and exit stations" do
      journey = {station => station}
      expect(oystercard.journey_log).to include journey
    end

  end


end
