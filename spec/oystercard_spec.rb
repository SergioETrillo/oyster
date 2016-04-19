require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:max_balance) { Oystercard::MAXIMUM_BALANCE }
  let(:min_balance) { Oystercard::MINIMUM_BALANCE}
  describe '#initialize' do

    it "creates a new card with a balance of 0" do
      expect(oystercard.balance).to eq 0
    end

    it "is initially not 'in journey'" do
      expect(oystercard).not_to be_in_journey
    end
  end

  it "allows user to top up" do
    random = rand(max_balance)
    expect { oystercard.top_up random }.to change { oystercard.balance }.by random
  end

  it "raises an error if the maximum allowable balance is exceeded" do
    oystercard.top_up(max_balance)
    message = "Maximum balance of #{max_balance} exceeded"
    expect { oystercard.top_up(90) }.to raise_error message
  end

  it "deducts the journey fare from the oystercard" do
    oystercard.top_up(90)
    expect { oystercard.deduct(5) }.to change { oystercard.balance }.by -5
  end

  it "touches in and reports 'in journey'" do
    oystercard.top_up(20)
    oystercard.touch_in
    expect(oystercard).to be_in_journey
  end

  it "prevents journey if oystercard doesn't have minimum balance" do
    expect { oystercard.touch_in }.to raise_error "Insufficient balance for journey"
  end

  it "touches out and ends journey" do
    oystercard.top_up(20)
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard).not_to be_in_journey
  end

end
