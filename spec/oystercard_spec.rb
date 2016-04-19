require 'oystercard'

describe Oystercard do

  	subject(:oystercard){ described_class.new }

  	it { is_expected.to respond_to(:balance) }

  	it 'has a default balance of 0 on initialization' do
    	expect(oystercard.balance).to eq 0
  	end

	it "is not in journey, when card is issued" do
	 	expect(oystercard).not_to be_in_journey
	end

  	it 'tops up the balance' do
  		expect{oystercard.top_up(20)}.to change{oystercard.balance}.by 20
  	end	
	
  	it "raises an error when the maximum balance is exceeded" do
 		card_max = Oystercard::MAXIMUM_BALANCE 	
  		oystercard.top_up(card_max)

  		expect {oystercard.top_up(1)}.to raise_error "maximum balance of #{card_max} exceeded"
	end

	it "deducts a journey fare from the balance" do
		expect{oystercard.deduct(5)}.to change{oystercard.balance}.by -5
	end


	it "gives the card a touch in method" do 
		oystercard.touch_in
		expect(oystercard).to be_in_journey
	end

	it "gives the card a touch out method" do 
		oystercard.touch_in
		oystercard.touch_out
		expect(oystercard).not_to be_in_journey
	end

end