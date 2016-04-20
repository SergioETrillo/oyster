require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  let(:starting_station) { double :starting_station }
  let(:ending_station)  { double :ending_station }

  context 'when setting up' do
    it 'has an empty journey record' do
      expect(journey.current).to be_empty
    end
  end

  context 'when passed an entry station' do
    it 'adds an entry station to the current journey' do
      journey.start_journey(starting_station)
      expect(journey.current[:starting_station]).to eq starting_station
    end
  end

  context 'when passed an exit station' do
    before { journey.end_journey(ending_station) }
    it 'adds an exit station to the current journey' do
      expect(journey.current[:ending_station]).to eq ending_station
    end

    it 'completes journey' do
      expect(journey).to be_complete
    end
    # it 'updates the history' do
    #   journey.start_journey(starting_station)
    #   journey.end_journey(ending_station)
    #   expect((journey.get_history).last).to eq({starting_station: starting_station, ending_station: ending_station})
    # end
  end

  context 'calculating fare' do

    it "test for a correct journey" do
      journey.start_journey(starting_station)
      journey.end_journey(ending_station)
      expect(journey).to be_correct
    end

    context "tests for an incorrect journeys" do
      it "returns incorrect if no starting_station" do
        journey.end_journey(ending_station)
        expect(journey).not_to be_correct
      end

      it "returns incorrect if no ending_station" do
        journey.start_journey(starting_station)
        expect(journey).not_to be_correct
      end
    end

    it 'MINIMUM_FARE for the correct journey' do
      journey.start_journey(starting_station)
      journey.end_journey(ending_station)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it 'PENALTY for any incorrect journey' do
      journey.end_journey(ending_station)
      expect(journey.fare).to eq Journey::PENALTY
    end
  end
end

# In order to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
