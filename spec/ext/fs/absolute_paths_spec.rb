require "hastings/ext/fs/absolute_paths"

describe Hastings::FS::AbsolutePaths do
  subject { Class.new(File) { include Hastings::FS::AbsolutePaths } }
  before { FileUtils.touch("foo") }
  after { FileUtils.rm("foo") }

  describe ".new" do
    subject { super().new("foo") }

    it "replaces the path with the absolute path" do
      expect(subject.path).to eq(File.absolute_path("foo"))
    end
  end
end
