require 'journey'


describe Journey do

  let(:journey) {described_class.new}

  it 'should have an entry_station' do
    expect(journey).to respond_to :entry_station
  end
  it 'should have an exit_station' do
    expect(journey).to respond_to :exit_station
  end
  it 'should return true if journey is complete' do
    allow(journey).to receive(:is_complete?).and_return(true)
    expect(journey.is_complete?).to be true
  end
  it 'should calculate a minimum fare' do
    allow(journey).to receive(:is_complete?).and_return(true)
    expect(journey.calculate_fare).to eq 1
  end
  it 'should give a penalty fare of 6 if journey is not complete' do
    allow(journey).to receive(:is_complete?).and_return(false)
    expect(journey.calculate_fare).to eq 6
  end

end
