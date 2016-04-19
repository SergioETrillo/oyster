require "station"

describe Station do
  context "when initializing" do
    subject {described_class.new(name: "Aldgate", zone: 1)}
    it "has a name argument Aldgate" do
      expect(subject.name).to eq "Aldgate"
    end

    it "has a zone argument 1" do
      expect(subject.zone).to eq 1
    end
  end
end