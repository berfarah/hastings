require "hastings/ext/file"
require "hastings/ext/dir"
require "hastings/ext/date_range"

describe Hastings::File do
  subject { described_class.new("foo") }
  before(:all) { File.write("foo", "example text\n") }
  after(:all)  { File.delete("foo") }

  it { is_expected.to be_a ::File }
  it { is_expected.to be_a Hastings::FS::AbsolutePaths }
  it { is_expected.to be_a Hastings::FS::Path }
  it { is_expected.to be_a Hastings::FS::Stat }

  describe "#lines" do
    subject { super().lines }
    it { is_expected.to be 1 }
  end
end
