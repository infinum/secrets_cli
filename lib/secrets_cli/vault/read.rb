module SecretsCli
  module Vault
    class Read < SecretsCli::Vault::Base
      def initialize(options)
        super
        options.default verbose: true
        SecretsCli::Check::Secrets.new(options).call
        @secrets_storage_key = options.secrets_storage_key || config.secrets_storage_key
      end

      private

      attr_reader :secrets_storage_key

      def command
        secret = ::Vault.logical.read(secrets_full_storage_key)
        secret.data[SECRETS_FIELD]
      end
    end
  end
end
