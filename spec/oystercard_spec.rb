require 'oystercard'

describe Oystercard do

  	subject(:oystercard){ described_class.new }
    let (:card_max) { Oystercard::MAXIMUM_BALANCE }

    describe "#initialization" do
    	it 'has a default balance of 0 on initialization' do
    	  expect(oystercard.balance).to eq 0
  	  end

	    it "is not in journey, when card is issued" do
	 	    expect(oystercard).not_to be_in_journey
	    end
    end

  	it 'tops up the balance' do
  		expect{ oystercard.top_up(card_max) }.to change{oystercard.balance}.by card_max
  	end

  	it "raises an error when the maximum balance is exceeded" do
  		oystercard.top_up(card_max)
  		expect {oystercard.top_up(1)}.to raise_error "maximum balance of #{card_max} exceeded"
	end

	it "deducts a journey fare from the balance" do
		expect{oystercard.deduct(5)}.to change{oystercard.balance}.by -5
	end

  it "prevents journey if oystercard doesn't have minimum balance" do
    expect { oystercard.touch_in }.to raise_error "Insufficient balance for journey"
  end

	it "touches in and starts journey" do
    oystercard.top_up(card_max)
    oystercard.touch_in
		expect(oystercard).to be_in_journey
	end

	it "touches out and ends journey" do
    oystercard.top_up(card_max)
    oystercard.touch_in
		oystercard.touch_out
		expect(oystercard).not_to be_in_journey
	end

end
