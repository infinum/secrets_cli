module SecretsCli
  module Vault
    class Base
      include SecretsCli::Helpers

      attr_reader :options

      def initialize(options)
        @options = options
      end

      def call
        print_verbose(command) if config.verbose
        Open3.popen2e(command) do |_stdin, stdout_and_stderr, wait_thr|
          if wait_thr.value.success?
            prompt.ok(stdout_and_stderr.read)
          else
            error(stdout_and_stderr.read)
          end
        end
      end

      private

      def command
        fail NotImplementedError
      end

      def secrets_full_storage_key
        File.join(secrets_storage_key, config.environment)
      end
    end
  end
end
