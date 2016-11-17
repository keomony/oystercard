require 'oystercard'

describe OysterCard do
  subject(:oystercard) {described_class.new}
  let(:station) {double :station}

  it "should check that it has an empty list of journeys by default" do
    expect(oystercard.journey_log).to be_empty
  end

  context "balance" do
    it { is_expected.to respond_to(:balance) }
  end

  context "insufficient funds" do
    before do
      oystercard.top_up(0.9)
    end
    it "should raise an error if the balance is less than 1" do
      entry_station = "King's cross"
      expect{ oystercard.touch_in(entry_station) }.to raise_error("Insufficient funds. You need to top up.")
    end

  end

  describe "journey" do
    context "sufficient funds" do
      before do
        oystercard.top_up(10)
        oystercard.touch_in(station)
      end
      it "deducts minimum fare when touched ou" do
        expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-1)
      end
      it "deducts penalty fare when touching in twice" do
        expect{oystercard.touch_in(station)}.to change{oystercard.balance}.by(-6)
      end
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it "should increase the balance by top_up value" do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

      it "should raise an error if max. limit is exceeeded" do
        message = "Cannot top up: £#{OysterCard::MAXIMUM_LIMIT} limit would be exceeded"
        expect {oystercard.top_up(100)}.to raise_error(message)
      end

  end

describe "#touching out" do
  it "stores the exit station" do
    oystercard.top_up(90)
    oystercard.touch_in("Kings Cross")
    oystercard.touch_out("Euston")
    journey = {"Kings Cross" => "Euston"}
    expect(oystercard.journey_log).to include journey
  end
end


end
