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
        fail NotImplementedError
      end

      def secrets_full_storage_key
        File.join(secrets_storage_key, config.environment)
      end
    end
  end
end
