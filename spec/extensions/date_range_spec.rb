require "hastings/extensions/date_range"

describe Hastings::DateRange do
  describe "#include?" do
    context "when date is in range" do
      it "is true" do
        range = described_class.new((Date.today - 5), (Date.today + 5))
        expect(range.include? Date.today).to be true
      end
    end

    context "when date isn't in range" do
      it "is false" do
        range = described_class.new((Date.today + 5), (Date.today + 15))
        expect(range.include? Date.today).to be false
      end
    end
  end
end
