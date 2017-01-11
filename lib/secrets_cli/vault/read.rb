module SecretsCli
  module Vault
    class Read < SecretsCli::Vault::Base
      def initialize(options)
        super
        options.default(verbose: !options.ci_mode)
        SecretsCli::Check::Secrets.new(options).call
        @secrets_storage_key = options.secrets_storage_key || config.secrets_storage_key
      end

      private

      attr_reader :secrets_storage_key

      def command
        secrets = ::Vault.logical.read(secrets_full_storage_key)
        error!("There are no secrets in #{secrets_full_storage_key}") if secrets.nil?
        secrets.data[SECRETS_FIELD]
      end
    end
  end
end
