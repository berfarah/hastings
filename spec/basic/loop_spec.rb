require "hastings/basic/loop"

describe Hastings::Basic::Loop do
  let(:each_inspect) { -> (arg) { described_class.new(arg).each.inspect } }
  let(:enum_inspect) do
    -> (arg) { described_class.new(arg).instance_variable_get("@enum") }
  end

  describe "#each" do
    context "with an Enumerable" do
      it "proxies each" do
        arr = [1, 2, 3]
        expect(each_inspect[arr]).to eq(arr.each.inspect)

        hash = { one: 1, two: 2, three: 3 }
        expect(each_inspect[hash]).to eq(hash.each.inspect)

        # Custom enumerable => #each
        struct = Struct.new(:var) do
          def each; end
        end.new("foo")
        expect(each_inspect[struct]).to eq(struct.each.inspect)
      end
    end

    context "with a String" do
      it "splits by line ending" do
        expect(enum_inspect["some\nstring\nhere"]).to eq(%w(some string here))
      end

      it "splits by commas" do
        expect(enum_inspect["some,string,here"]).to eq(%w(some string here))
      end
    end

    context "with a Fixnum" do
      it "iterates n times" do
        expect(enum_inspect[5]).to eq(1..5)
      end
    end

    context "with a new Object" do
      it "fails" do
        expect do
          described_class.new(Object.new)
        end.to raise_error(NotImplementedError)
      end
    end
  end
end
