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
    it 'updates the history' do
      journey.start_journey(starting_station)
      journey.end_journey(ending_station)
      expect((journey.get_history).last).to eq({starting_station: starting_station, ending_station: ending_station})
    end
  end
end
