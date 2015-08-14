require "hastings/ext/shell"

module Hastings
  # A collection of information about the machine user environment. Uses unix
  # shell functions and environment variables
  module User
    module_function

    # User ID
    # @return [Fixnum]
    def uid
      Hastings::Shell.run("id -u").to_i
    end

    # Group ID
    # @return [Fixnum]
    def gid
      Hastings::Shell.run("id -g").to_i
    end

    # Home Directory
    # @return [String]
    def home
      ENV["HOME"]
    end

    # Host Name
    # @return [string]
    def host
      Hastings::Shell.run("hostname")
    end

    # User Name
    # @return [Strin]
    def user
      ENV["USER"]
    end
  end
end
