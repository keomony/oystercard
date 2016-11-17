require 'journey.rb'

describe Journey do

  subject(:journey) { described_class.new(:station) }
  let(:exit_station) { double :station }

  describe '#initialize' do

    it 'has entry station' do
      expect(journey.entry_station).to eq :station
    end

    it "defaults entry station to nil"  do
      journey2 = Journey.new()
      expect(journey2.entry_station).to eq nil
    end

    it "should have penalty fare by default" do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

  end

  describe '#end_journey' do

    it 'sets exit station' do
      journey.end(exit_station)
      expect(journey.exit_station).to eq exit_station
    end

  end

  it 'should save a complete journey' do
    journey.end(exit_station)
    store = {:station => exit_station}
    expect(journey.log).to include store
  end

  it 'knows when card is in a journey' do
    expect(journey).to be_in_journey
  end

  it 'knows when a card is not in a journey' do
    journey.end(exit_station)
    expect(journey).not_to be_in_journey
  end

  describe '#fare' do

    it {is_expected.to respond_to(:calculate_fare)}

    it 'returns penalty fare of 6 if no entry' do
      journey2 = Journey.new()
      journey2.end(exit_station)
      expect(journey2.calculate_fare).to eq Journey::PENALTY_FARE
    end

    it 'returns penalty fare of 6 if no exit' do
      expect(journey.calculate_fare).to eq Journey::PENALTY_FARE
    end

    it 'returns minimum fare of 1 if we have entry and exit stations' do
      journey.end(exit_station)
      expect(journey.calculate_fare).to eq Journey::MINIMUM_FARE
    end

  end

end
