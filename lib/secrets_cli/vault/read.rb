module SecretsCli
  module Vault
    class Read < SecretsCli::Vault::Base
      def initialize(options)
        super
        SecretsCli::Check::Secrets.new(:read, options).call
        @secrets_storage_key = options.secrets_storage_key || config.secrets_storage_key
      end

      private

      attr_reader :secrets_storage_key

      def command
        secrets = backend.read(secrets_full_storage_key)
        error!("There are no secrets in #{config.vault_addr} #{secrets_full_storage_key}") if secrets.nil?
        secrets.data[SECRETS_FIELD]
      end
    end
  end
end
