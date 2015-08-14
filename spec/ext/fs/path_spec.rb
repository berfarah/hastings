require "hastings/ext/fs/path"

describe Hastings::FS::Path do
  subject { Struct.new(:path) { include Hastings::FS::Path }.new(path) }
  let(:path) { File.absolute_path("foo") }
  before { FileUtils.touch("foo") }
  after { FileUtils.rm("foo") }

  describe "#pathname" do
    subject { super().pathname }

    it { is_expected.to be_a Pathname }
    it { is_expected.to eq(Pathname.new(path)) }
  end

  describe "#basename" do
    subject { super().basename }

    it { is_expected.to be_a String }
    it { is_expected.to eq "foo" }
  end

  describe "#dirname" do
    subject { super().dirname }

    it { is_expected.to be_a String }
    it { is_expected.to eq path[0..-5] }
  end

  describe "#join" do
    subject { super().join("bar") }

    it { is_expected.to be_a String }
    it { is_expected.to eq File.join(path, "bar") }
  end
end
