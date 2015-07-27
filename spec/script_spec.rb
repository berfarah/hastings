require "active_support"
require "active_support/core_ext"
require "hastings/script"

describe Hastings::Script do
  subject do
    described_class.new do
      name "Example name"
      description "Does things with things"
      run_every 5.hours
      run_at "2015-09-25 21:03"
      run do
        "I am in a proc"
      end
    end
  end

  describe "#run" do
    it "executes the code via the DSL" do
      expect(Hastings::Dsl).to receive(:new)
      subject.run
    end
  end

  describe "#meta" do
    it "returns a Meta class" do
      expect(subject.meta).to be_a(Hastings::Script::Meta)
    end

    it "has a name" do
      expect(subject.meta.name).to eq("Example name")
    end

    it "has a description" do
      expect(subject.meta.description).to eq("Does things with things")
    end

    it "has a duration" do
      expect(subject.meta.run_every).to eq(18_000)
    end

    it "has a run-date" do
      expect(subject.meta.run_at).to eq(DateTime.parse("2015-09-25 21:03"))
    end

    it "has a proc to run" do
      expect(subject.meta.run.call).to eq("I am in a proc")
    end
  end
end
