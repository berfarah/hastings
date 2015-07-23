require "fakefs/spec_helpers"
RSpec.configure do |c|
  c.include FakeFS::SpecHelpers, fakefs: true
end

require "simplecov"
SimpleCov.start { add_filter "_spec" }

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "hastings"
