require "hastings/ext/user"

describe Hastings::User do
  subject { Hastings::User }

  [:uid, :gid].each do |method_name|
    describe ".#{method_name}" do
      subject { super().public_send method_name }
      it { is_expected.to be_a Fixnum }
      it { is_expected.not_to be 0 }
    end
  end

  [:home, :user, :host].each do |method_name|
    describe ".#{method_name}" do
      subject { super().public_send method_name }
      it { is_expected.to be_a String }
      it { is_expected.not_to eq "" }
    end
  end
end
