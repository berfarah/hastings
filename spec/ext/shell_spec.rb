require "hastings/ext/shell"

describe Hastings::Shell do
  subject { described_class.new }

  describe ".run" do
    it "passes arguments to an instance of Shell" do
      expect_any_instance_of(described_class).to receive(:run)
      described_class.run("true")
    end
  end

  describe "#run" do
    context "when the command returns a zero exit code" do
      it "returns stdout" do
        expect(subject.run("echo my_message")).to eq("my_message")
      end
    end

    context "when the command returns a non-zero exit code" do
      it "raises a Shell::Error" do
        err_msg = "my_error_message"

        expect do
          subject.run("echo #{err_msg} >&2 ; exit 1")
        end.to raise_error(Hastings::Shell::Error, err_msg)
      end

      context "when instantiated with raise_error:false" do
        it "returns false" do
          expect(described_class.new(raise_error: false)
            .run("false")).to be nil
        end
      end
    end
  end
end
