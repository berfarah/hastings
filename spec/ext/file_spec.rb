require "hastings/ext/file"
require "hastings/ext/dir"
require "hastings/ext/date_range"

describe Hastings::File do
  subject(:foo) { described_class.new("foo") }
  before(:all) { File.open("foo", "w") {} }
  after(:all)  { File.delete("foo") }

  subject(:today) { -> (i) { (Date.today + i).to_time } }

  it "inherits from File" do
    expect(foo).to be_a File
  end

  describe "#basename" do
    it "should return just the base name of the file" do
      expect(foo.basename).to eq("foo")
    end
  end

  describe "#newer_than?" do
    it "is true for newer files" do
      expect(foo.newer_than? today[-1]).to be true
    end

    it "is false for older files" do
      expect(foo.newer_than? today[+1]).to be false
    end
  end

  describe "#older_than?" do
    it "is true for older files" do
      expect(foo.older_than? today[+1]).to be true
    end

    it "is false for newer files" do
      expect(foo.older_than? today[-1]).to be false
    end
  end

  describe "#created_on?" do
    it "is true if the file was created on that day" do
      expect(foo.created_on? today[0].to_date).to be true
    end

    it "is false if the file was created on another day" do
      expect(foo.created_on? today[-1].to_date).to be false
    end
  end

  describe "#created_between?" do
    it "is true if it was created in the date range" do
      range = Hastings::DateRange.new(Date.today - 1, Date.today + 1)
      expect(foo.created_between? range).to be true
    end

    it "is false if it wasn't created in the date range" do
      range = Hastings::DateRange.new(Date.today + 2, Date.today + 5)
      expect(foo.created_between? range).to be false
    end
  end

  describe "#copy_to" do
    context "when given a directory" do
      before { FileUtils.mkdir_p("bar") }
      after  { FileUtils.rm_rf("bar") }

      it "should copy the file to the directory" do
        foo.copy_to("bar")
        expect(File.exist? "bar/foo").to be true
      end

      it "shouldn't overwrite if overwrite is disabled" do
        expect(foo.copy_to("bar", overwrite: false)).to be nil
        expect(foo.copy_to("bar", overwrite: false)).to be false
      end

      context "given a dir object" do
        it "should copy the file to the directory" do
          dir = Dir.new("bar")
          foo.copy_to(dir)
          expect(File.exist? "bar/foo").to be true
        end
      end
    end

    context "when given a non-directory path" do
      it "copies the file to the path" do
        foo.copy_to("baz")
        expect(File.exist? "baz").to be true
        File.delete("baz")
      end

      it "shouldn't overwrite if overwrite is disabled" do
        expect(foo.copy_to("baz", overwrite: false)).to be nil
        expect(foo.copy_to("baz", overwrite: false)).to be false
      end
    end
  end
end
