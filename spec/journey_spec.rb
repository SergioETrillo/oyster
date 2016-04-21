require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  let(:starting_station) { double :starting_station, zone: 1 }
  let(:ending_station)  { double :ending_station, zone: 1 }
  let(:station_random1) {double :station_random1, zone: rand(9)}
  let(:station_random2) {double :station_random2, zone: rand(9)}
  # let(:stationz7) {double :stationz4, zone: 7}
  let(:stationz3) {double :stationz4, zone: 3}

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

  context 'calculating journey fares' do
    before(:each) do
      @correct_fare = (station_random1.zone - station_random2.zone).abs + 1
    end
    it 'MINIMUM_FARE for two stations within same zone' do
      journey.start_journey(station_random1)
      journey.end_journey(station_random2)
      expect(journey.fare).to eq @correct_fare
    end

    it 'cost of 3 for a station in zone 1 and a station in zone 3' do
      @correct_fare = (starting_station.zone - stationz3.zone).abs + 1
      journey.start_journey(starting_station)
      journey.end_journey(stationz3)
      expect(journey.fare).to eq @correct_fare
    end

    it 'tests correct fare calculated with random zones' do
     @correct_fare = (station_random1.zone - station_random2.zone).abs + 1
      journey.start_journey(station_random1)
      journey.end_journey(station_random2)
      expect(journey.fare).to eq @correct_fare
    end


  end

  context "when journey not correct" do
    it 'PENALTY for any incorrect journey' do
      journey.end_journey(ending_station)
      expect(journey.fare).to eq Journey::PENALTY
    end
  end

  context "correctness of journeys" do
    it "returns incorrect if no starting_station" do
      journey.end_journey(ending_station)
      expect(journey).not_to be_correct
    end

    it "returns incorrect if no ending_station" do
      journey.start_journey(starting_station)
      expect(journey).not_to be_correct
    end

    it "test for a correct journey" do
      journey.start_journey(starting_station)
      journey.end_journey(ending_station)
      expect(journey).to be_correct
    end
  end
end

# In order to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
