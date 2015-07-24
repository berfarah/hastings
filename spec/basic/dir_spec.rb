require "hastings/basic/dir"

describe Hastings::Basic::Dir do
  subject(:foo_bar) { described_class.new("foo_bar") }
  let(:path) { -> (arr) { arr.map(&:path) } }
  before(:all) do
    FileUtils.mkdir_p("foo_bar")
    @files = %w(bazinga caramba yahoo)
    @files.each { |f| File.open("foo_bar/#{f}", "w") {} }
  end
  after(:all)  { FileUtils.rm_rf("foo_bar") }

  subject(:files_arr) do
    Dir.chdir("foo_bar") { @files.map(&Hastings::Basic::File.method(:new)) }
  end

  it "inherits from Dir" do
    expect(foo_bar).to be_a Dir
  end

  describe "#files" do
    context "when not passed hash args" do
      it "lists the files in a directory" do
        expect(path[foo_bar.files]).to eq(path[files_arr])
      end

      it "matches files by glob" do
        expect(path[foo_bar.files("baz*")]).to eq(path[[files_arr.first]])
      end
    end

    context "when passed hash args" do
      it "filters by criteria" do
        expect(
          path[foo_bar.files on_day: Date.today.to_s]
        ).to eq(path[files_arr])
      end

      it "matches files by glob and criteria" do
        expect(
          path[foo_bar.files "baz*", on_day: Date.today.to_s]
        ).to eq(path[[files_arr.first]])
      end

      it "matches by multiple criteria" do
        pending("having more than one criteria that can be chained")
        expect(
          path[foo_bar.files on_day: Date.today.to_s, some_method: nil]
        ).to eq(path[files_arr])
      end
    end
  end
end
