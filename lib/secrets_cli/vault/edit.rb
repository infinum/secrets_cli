module SecretsCli
  module Vault
    class Edit < SecretsCli::Vault::Base
      def initialize(options)
        super
        SecretsCli::Check::Secrets.new(:edit, options).call
        @secrets_storage_key = options.secrets_storage_key || config.secrets_storage_key
      end

      private

      attr_reader :secrets_storage_key

      def command
        secrets = ::Vault.logical.read(secrets_full_storage_key)
        new_secrets = ask_editor(content(secrets))
        compare(content(secrets), new_secrets)
        ::Vault.logical.write(secrets_full_storage_key, SECRETS_FIELD => new_secrets)
        new_secrets
      end

      def content(secrets)
        return '' if secrets.nil?
        secrets.data[SECRETS_FIELD]
      end
    end
  end
end
