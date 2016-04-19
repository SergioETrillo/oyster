require "journey"

describe Journey do
  let(:entry_station) {double(:entry_station)}
  let(:card) {double(:card, touch_in: entry_station) }
  context "when initializing" do
    it "has an empty list of journeys" do
      expect(subject.journeys).to be_empty
    end

    it "is not in journey" do
      expect(subject).not_to be_in_journey
    end

    it "starts a journey when touch_in" do
      allow(card).to receive(:touch_in)
      expect(subject).to be_in_journey
    end


  end
end

# it should be responsible for starting a journey, finishing a journey, calculating the fare of a journey, and returning whether or not the journey is complete.