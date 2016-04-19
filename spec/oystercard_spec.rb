require 'oystercard'

describe Oystercard do

  	subject(:oystercard){ described_class.new }
    let (:card_max) { Oystercard::MAXIMUM_BALANCE }
    let (:min_fare) { Oystercard::MINIMUM_FARE }
    let (:station) {double :station }

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

  it "prevents journey if oystercard doesn't have minimum balance" do
    expect { oystercard.touch_in(station) }.to raise_error "Insufficient balance for journey"
  end

  it "remembers a starting point station" do
    oystercard.top_up(card_max)
    oystercard.touch_in(station)
    expect(oystercard.starting_station).to eq station 
  end  

	it "touches in and starts journey" do
    oystercard.top_up(card_max)
    oystercard.touch_in(station) 
		expect(oystercard).to be_in_journey
	end

  it "clears a starting point station" do
    oystercard.top_up(card_max)
    oystercard.touch_in(station)
    oystercard.touch_out
    expect(oystercard.starting_station).to be nil
  end

	it "touches out and ends journey" do
    oystercard.top_up(card_max)
    oystercard.touch_in(station) 
		oystercard.touch_out
		expect(oystercard).not_to be_in_journey
	end

  it 'deducts the correct journey fare from my card when touching out' do
    oystercard.top_up(card_max)
    oystercard.touch_in(station) 
    expect { oystercard.touch_out }.to change { oystercard.balance }.by -(min_fare)
  end

end
