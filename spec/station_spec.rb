require 'station'

describe Station do

  subject(:station) { described_class.new(name: "Aldgate", zone: 1) }

  context 'when setting up' do
    it 'has a name' do
      expect(station.name).to eq("Aldgate")
    end

    it 'has a zone' do
      expect(station.zone).to eq(1)
    end
  end
end
