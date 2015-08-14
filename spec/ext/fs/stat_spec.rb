require "hastings/ext/date_range"
require "hastings/ext/fs/stat"

describe Hastings::FS::Stat do
  subject { Class.new(File) { include Hastings::FS::Stat }.new("foo") }
  before(:all) { FileUtils.touch("foo") }
  after(:all) { FileUtils.rm("foo") }

  [:accessed, :created, :modified].each do |name|
    describe "##{name}" do
      subject { super().public_send name }

      it { is_expected.to be_a Time }
      it "should have been #{name} today" do
        expect(subject.to_date).to eq(Date.today)
      end
    end

    describe "##{name}_on?" do
      subject { super().public_send :"#{name}_on?", date }

      describe "given today" do
        let(:date) { Date.today }
        it { is_expected.to be true }
      end

      describe "given tomorrow" do
        let(:date) { Date.today + 1 }
        it { is_expected.to be false }
      end
    end

    describe "##{name}_between?" do
      subject { super().public_send :"#{name}_between?", range }

      describe "when it's in the range" do
        let(:range) { Hastings::DateRange.new Date.today - 5, Date.today }
        it { is_expected.to be true }
      end

      describe "when it's not in the range" do
        let(:range) { Hastings::DateRange.new Date.today + 5, Date.today + 20 }
        it { is_expected.to be false }
      end
    end
  end

  describe "#newer_than?" do
    subject { super().newer_than? time }

    describe "given now" do
      let(:time) { Time.now }
      it { is_expected.to be false }
    end

    describe "given 5 minutes ago" do
      let(:time) { Time.now - 5 * 60 }
      it { is_expected.to be true }
    end
  end

  describe "#older_than?" do
    subject { super().older_than? time }

    describe "given now" do
      let(:time) { Time.now }
      it { is_expected.to be true }
    end

    describe "given 5 minutes ago" do
      let(:time) { Time.now - 5 * 60 }
      it { is_expected.to be false }
    end
  end
end
