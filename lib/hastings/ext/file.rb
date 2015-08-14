require "hastings/ext/fs"

module Hastings
  # {File} is an extension of {::File} with additional user-friendly methods
  # (see included modules)
  class File < ::File
    include Hastings::FS::AbsolutePaths
    include Hastings::FS::Path
    include Hastings::FS::Stat

    # @return [Fixnum] amount of lines in the file
    def lines
      each_line.count
    end
  end
end
