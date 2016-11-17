require 'journey.rb'

describe Journey do

  subject(:journey1) { described_class.new(:station) }
  let(:exit_station) { double :station }

  # it { is_expected.to respond_to(:entry_station)}
  # it { is_expected.to respond_to(:exit_station)}
  #
  # it { is_expected.to respond_to(:start_journey).with(1).argument }
  #
  # it { is_expected.to respond_to(:end_journey).with(1).argument }

  describe '#initialize' do

    it 'has entry station' do
      expect(journey1.entry_station).to eq :station
    end

    it "default's entry station to nil"  do
      journey2 = Journey.new()
      expect(journey2.entry_station).to eq nil
    end

  end

  describe '#end_journey' do

    it 'sets exit station' do
      journey1.end(exit_station)
      expect(journey1.exit_station).to eq exit_station
    end

  end

  it 'should save a complete journey' do
    journey1.end(exit_station)
    store = {:station => exit_station}
    expect(journey1.log).to include store
  end

  it 'knows when card is in a journey' do
    expect(journey1).to be_in_journey
  end

  it 'knows when a card is not in a journey' do
    journey1.end(exit_station)
    expect(journey1).not_to be_in_journey
  end

end
