require "hastings/ext/file"

module Hastings
  # {Dir} is an extension of {::Dir} with additional user-friendly methods
  # (see included modules)
  class Dir < ::Dir
    include Hastings::FS::AbsolutePaths
    include Hastings::FS::Path
    include Hastings::FS::Stat

    # @!group Stat methods

    # @return [Time] the created timestamp of the directory
    def ctime
      File.ctime(path)
    end

    # @return [Time] the modified timestamp of the directory
    def mtime
      File.mtime(path)
    end

    # @return [Time] the accessed timestamp of the directory
    def atime
      File.atime(path)
    end

    # @!endgroup

    # @!group List methods

    # @param str [String] following the {::Dir#glob} format
    # @return [Array[String]] files in the directory as path strings
    def glob(str = nil)
      Dir[pathname.join(str || "*")]
    end

    # Instantiates all the entries in a directory into their respective
    # {Hastings::File} and {Hastings::Dir} objects.
    #
    # To filter by methods, you can pass arguments of methods expected to be
    # truthy. They are run in order given in the hash.
    # @example Files and directories newer than 5 minutes ago
    #   dir.list("*", :newer_than? => Time.now - 5*60)
    #
    # @param str [String] following the {::Dir#glob} format
    # @param args [Hash] methods to be filtered by when truthy
    # @return [Array[Hastings::File|Hastings::Dir]] a list of entries in the
    #   directory, instantiated to files or directories
    def list(str = nil, **args)
      args.inject(instantiate_list glob(str)) do |entries, (method, arg)|
        entries.select { |f| f.public_send(method, *Array(arg)) }
      end
    end

    # See {#list}
    # @return [Array[Hastings::File]] a list of instantiated file entries
    def files(str = nil, **args)
      list(str, is_a?: Hastings::File, **args)
    end

    # See {#list}
    # @return [Array[Hastings::Dir]] a list of instantiated dir entries
    def dirs(str = nil, **args)
      list(str, is_a?: Hastings::Dir, **args)
    end

    # @!endgroup

    private

      def instantiate_list(entries)
        entries.map do |entry|
          case
          when ::File.file?(entry) then Hastings::File.new(entry)
          when ::File.directory?(entry) then Hastings::Dir.new(entry)
          end
        end.compact
      end
  end
end
