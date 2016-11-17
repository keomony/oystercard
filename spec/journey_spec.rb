require 'journey.rb'

describe Journey do

  subject(:journey) {described_class.new}
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  # it { is_expected.to respond_to(:entry_station)}
  # it { is_expected.to respond_to(:exit_station)}
  #
  # it { is_expected.to respond_to(:start_journey).with(1).argument }
  #
  # it { is_expected.to respond_to(:end_journey).with(1).argument }

  describe '#start_journey' do

    it 'sets entry station' do
      journey.start(entry_station)
      expect(journey.entry_station).to eq entry_station
    end

  end

  describe '#end_journey' do

    it 'sets exit station' do
      journey.end(exit_station)
      expect(journey.exit_station).to eq exit_station
    end

  end

  it 'should save a complete journey' do
    journey.start(entry_station)
    journey.end(exit_station)
    store = {entry_station => exit_station}
    expect(journey.log).to include store
  end

  it 'knows when card is in a journey' do
    journey.start(entry_station)
    expect(journey).to be_in_journey
  end

  it 'knows when a card is not in a journey' do
    journey.start(entry_station)
    journey.end(exit_station)
    expect(journey).not_to be_in_journey
  end

end
