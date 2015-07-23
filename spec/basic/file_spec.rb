require "hastings/basic/file"

describe Hastings::Basic::File do
  subject(:foo) { described_class.new("foo") }
  before(:all) { File.open("foo", "w") {} }
  after(:all)  { File.delete("foo") }

  subject(:today) { -> (i) { (Date.today + i).to_s } }

  it "inherits from File" do
    expect(foo).to be_a File
  end

  describe "#basename" do
    it "should return just the base name of the file" do
      expect(foo.basename).to eq("foo")
    end
  end

  describe "#newer_than" do
    it "is true for newer files" do
      expect(foo.newer_than today[-1]).to be true
    end

    it "is false for older files" do
      expect(foo.newer_than today[+1]).to be false
    end
  end

  describe "#older_than" do
    it "is true for older files" do
      expect(foo.older_than today[+1]).to be true
    end

    it "is false for newer files" do
      expect(foo.older_than today[-1]).to be false
    end
  end

  describe "#on_day" do
    it "is true if the file was created on that day" do
      expect(foo.on_day today[0]).to be true
    end

    it "is false if the file was created on another day" do
      expect(foo.on_day today[-1]).to be false
    end
  end
end
