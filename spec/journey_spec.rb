require 'journey'


describe Journey do
  let(:journey) {described_class.new}

  it "should have an entry_station" do
    expect(journey).to respond_to :entry_station
  end
  it "should have an exit_station" do
    expect(journey).to respond_to :exit_station
  end

  context "is completed" do
    before do
      allow(journey).to receive(:is_complete?).and_return(true)
    end

    it "should return true" do
      expect(journey.is_complete?).to be true
    end
    it "should calculate a minimum fare of £#{Journey::MINIMUM_FARE}" do
      expect(journey.calculate_fare).to eq Journey::MINIMUM_FARE
    end

  end

  context "is not completed" do
    before do
      allow(journey).to receive(:is_complete?).and_return(false)
    end
    
    it "should give a penalty fare of £#{Journey::PENALTY_FARE}" do
      expect(journey.calculate_fare).to eq Journey::PENALTY_FARE
    end

  end

end
