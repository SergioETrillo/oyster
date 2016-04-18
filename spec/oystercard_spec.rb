require "oystercard"

describe Oystercard do
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

    context "maximum limit of £90 on balances" do
      it "raises error when top_up exceeds max balance " do
        subject.top_up(Oystercard::MAX_BALANCE)
        error_max = Oystercard::ERR_MAX_BALANCE
        expect{ subject.top_up(1) }.to raise_error error_max
      end
    end

    context "deduct the travel fare" do
      it "subtracts the cost of fare and updates balance" do
        subject.top_up(20)
        expect {subject.deduct 5.50}.to change{ subject.balance }.by -5.50
      end
    end
  end
end