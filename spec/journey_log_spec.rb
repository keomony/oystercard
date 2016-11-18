require 'journey_log'

describe JourneyLog do
  let(:journey_klass) { double :journey_klass }
  subject(:journey_log) { described_class.new(journey_klass) }
  let(:journey) { double :journey}
  let(:station) { double :station}

  describe "#start" do
    it "should respond to start method" do
      expect(journey_log).to respond_to(:start).with(1).argument
    end

    it "should start the journey" do
      expect(journey_klass).to receive(:new).with(station)
      journey_log.start(station)
    end

    it "should record the journey" do
      allow(journey_klass).to receive(:new).and_return journey
      subject.start(station)
      expect(subject.journeys).to include journey
    end

  end

end
