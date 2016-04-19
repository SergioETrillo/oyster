require "oystercard"

describe Oystercard do
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
  let(:loaded_card) do
    loaded_card = subject
    loaded_card.top_up(Oystercard::MAX_BALANCE)
    loaded_card
  end

  context "when new card" do
    it "has balance 0" do
      expect(subject.balance).to eq 0
    end
  end

  context "#top_up" do
    #it { is_expected.to respond_to(:top_up).with(1).argument }

    it "when top_up of 43 it has balance of 43 " do
      subject.top_up(43)
      expect(subject.balance).to eq 43
      #expect{ subject.top_up 43 }.to change{ subject.balance }.by 43
    end
  end

  context "maximum limit of £90 on balances" do
    it "raises error when top_up exceeds max balance " do
      error_max = Oystercard::ERR_MAX_BALANCE
      expect{ loaded_card.top_up(1) }.to raise_error error_max
    end
  end

  # context "deduct the travel fare" do
  #   it "subtracts the cost of fare and updates balance" do
  #     subject.top_up(20)
  #     expect { subject.touch_out }.to change{ subject.balance }.by -Oystercard::MIN_CHARGE
  #   end
  # end

  context "touch in and out" do
    before { subject.top_up Oystercard::MAX_BALANCE }

    it "when initialized card is not in journey" do
      expect(subject.in_journey?).to be false
    end

    it "when touch-in card is in-journey" do
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to be true
    end

    it "when touch in then out card is not in-journey" do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to be false
    end
  end

  context "minimum balance £1" do
    it "raises error if balance less than 1 when touch-in" do
      expect { subject.touch_in(entry_station)}.to raise_error Oystercard::ERR_NO_MONEY
    end
  end

  context "paying for journeys" do
    it "deducts the right amount when touch out" do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -Oystercard::MIN_CHARGE
    end
  end

  context "entry station" do
    it "remembers entry station when touch in" do
      subject.top_up(Oystercard::MAX_BALANCE)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    it "forgets entry station when touch out" do
      subject.top_up(Oystercard::MAX_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to be nil
    end
  end

  context "storing journey history" do
    it "stores a journey in journeys list" do
      loaded_card.touch_in(entry_station)
      loaded_card.touch_out(exit_station)
      expect(loaded_card.journeys.last).to eq journey
    end
  end
end