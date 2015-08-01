require "shellwords"
require "open3"

module Hastings
  # Commands
  class Shell
    class Error < StandardError; end
    def initialize(raise_error: true)
      @raise_error = raise_error
    end

    attr_reader :stdout, :stderr, :status

    def self.run(*args)
      new.run(*args)
    end

    def run(str)
      @cmd = Shellwords.split(str.shellescape)
      shell
    end

    private

      def shell
        Open3.popen3(*@cmd) do |_stdin, stdout, stderr, p|
          @stdout = stdout.read.strip
          @stderr = stderr.read.strip
          @status = p.value.exitstatus
        end
        fail_on_error! || return
        @stdout
      end

      def fail_on_error!
        @status == 0 || @raise_error && fail(
          Error, [@cmd.join(" "), @stderr].join("\n"))
      end
  end
end
