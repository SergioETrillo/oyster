require 'journey_log'

describe JourneyLog do
  subject(:journeylog) {described_class.new}
  let(:starting_station) { double :starting_station }
  let(:ending_station)  { double :ending_station }
  let(:current_journey) { {starting_station: starting_station, ending_station: ending_station} }

  context "when initialize" do
    it "creates a new journey" do
      expect(journeylog.journey).not_to be nil
    end
    it "history is empty" do
      expect(journeylog.get_history).to be_empty
    end
  end

  it 'updates the history on touch out' do
    journeylog.journey.start_journey(starting_station)
    journeylog.journey.end_journey(ending_station)
    expect((journeylog.journey.get_history).last).to eq({starting_station: starting_station, ending_station: ending_station})
  end

  it 'add the current journey' do
    journeylog.journey.start_journey(starting_station)
    journeylog.journey.end_journey(ending_station)
    journeylog.update_history
    expect(journeylog.get_history.last).to eq current_journey
  end

end







#  test drive the development of JourneyLog class
#  Initialize the JourneyLog with a journey_class parameter (hint: journey_class expects an object that knows how to create Journeys. Can you think of an object that already does this?)
#  #start should start a new journey with an entry station
#  a private method #current_journey should return an incomplete journey or create a new journey
#  #finish should add an exit station to the current_journey
#  #journeys should return a list of all previous journeys without exposing the internal array to external modification
#  remove redundant code from OysterCard class