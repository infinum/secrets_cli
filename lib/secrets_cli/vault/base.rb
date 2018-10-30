module SecretsCli
  module Vault
    class Base
      include SecretsCli::Helpers

      attr_reader :options

      def initialize(options)
        @options = options
      end

      def call
        options.verbose ? prompt.ok(command) : command
      rescue => exception
        error!(exception.message)
      end

      private

      def command
        raise NotImplementedError
      end

      def secrets_full_storage_key
        File.join(secrets_storage_key, config.environment)
      end

      def compare(first, second)
        diff = TTY::File.diff(first, second, verbose: false)
        return if diff == ''
        prompt.ok('There are some differences:')
        pretty_diff(diff)
        exit 0 unless prompt.yes?('Are you sure you want to override?')
      end
    end
  end
end
