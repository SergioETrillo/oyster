#user stories spec files for feature test
describe 'user stories' do
  # In order to use public transport
  # As a customer
  # I want money on my card

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  let(:oystercard) { Oystercard.new }
  let(:loaded_card) do
    loaded_card = Oystercard.new
    loaded_card.top_up(card_max)
    loaded_card
  end
  let(:card_max) { Oystercard::MAXIMUM_BALANCE }
  let(:aldgate) { Station.new(name: "Aldgate", zone: 1) }
  let(:holborn) { Station.new(name: "Holborn", zone: 1) }
  let(:ipswich){ Station.new(name: "Ipswich", zone: 9) }

  context 'card balance and top_ups' do
    before { oystercard.top_up(card_max) }
    it 'allow top_ups in card' do
      expect(oystercard.balance).to eq card_max
    end

    # In order to protect my money
    # As a customer
    # I don't want to put too much money on my card

    it 'raises error if MAXIMUM_BALANCE exceed' do
      expect { oystercard.top_up(1) }.to raise_error "maximum balance of #{card_max} exceeded"
    end
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card

  context 'payments' do
    before do
      oystercard.top_up(card_max)
      oystercard.touch_in(aldgate)
      oystercard.touch_out(holborn)
    end
    it 'allows fare to be deducted from balance' do
      expect(oystercard.balance).to be < card_max
    end

    # In order to pay for my journey
    # As a customer
    # I need to pay for my journey when it's complete

    it 'no fare deducted on correct journeys when touch_in' do
      expect{ loaded_card.touch_in(aldgate) }.not_to change{ loaded_card.balance }
    end

    it ' fair deducted on correct journeys at touch out' do
      loaded_card.touch_in(aldgate)
      expect{ loaded_card.touch_out(holborn) }.to change{ loaded_card.balance }.by -Oystercard::MINIMUM_FARE
    end

  end

  # In order to get through the barriers
  # As a customer
  # I need to touch in and out

  context 'touch in and out' do
    before {}
    it 'allows to touch in' do
      expect { loaded_card.touch_in(aldgate) }.not_to raise_error
    end

    it 'allows to touch out' do
      expect { loaded_card.touch_in(holborn) }.not_to raise_error
    end

      # In order to pay for my journey
      # As a customer
      # I need to have the minimum amount for a single journey

    it 'raises error if minimum balance not available' do
      expect {oystercard.touch_in(aldgate) }.to raise_error "Insufficient balance for journey"
    end
  end

  context 'journey status information' do
    it 'at touch_out, info about entry station is known' do
      loaded_card.touch_in(aldgate)
      expect {oystercard}
    end
  end


end