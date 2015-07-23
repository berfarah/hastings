require "fakefs/spec_helpers"
require "fileutils"
RSpec.configure do |config|
  config.include FakeFS::SpecHelpers, fakefs: true
  config.before(:suite) do
    @tmpdir = "/tmp/ruby_tests/hastings"
    FileUtils.mkdir_p(@tmpdir)
    Dir.chdir(@tmpdir)
  end

  config.after(:suite) do
    FileUtils.rm_rf(@tmpdir)
  end
end

require "simplecov"
SimpleCov.start { add_filter "_spec" }

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "hastings"
