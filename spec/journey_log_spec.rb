require 'journey_log'

describe JourneyLog do

  let(:journey) {double :journey}
  let(:station) {double :station}
  let(:journey_klass){double :journey_klass, new: journey}
  subject(:journey_log) {described_class.new(journey_klass)}

  it {is_expected.to respond_to(:start).with(1).argument}

  describe '#start' do

    it 'starts a new journey' do
      expect(journey_klass).to receive(:new).with(station)
      journey_log.start(station)
    end

    it 'records a journey' do
      allow(journey_klass).to receive(:new).and_return journey
      journey_log.start(station)
      expect(subject.journeys).to include journey
    end


  #

end



end
