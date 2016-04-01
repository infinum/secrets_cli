module SecretsCli
  module Vault
    class Push < SecretsCli::Vault::Base
      attr_reader :secrets_storage_key, :secrets_field, :secrets, :secrets_file

      def initialize(options)
        super
        SecretsCli::Check::Secrets.new(options).call
        @secrets_storage_key = options.secrets_storage_key || config.secrets_storage_key
        @secrets_file = options.secrets_file || config.secrets_file
        @secrets = File.read(secrets_file)
      end

      def call
        return if !options.without_prompt && !are_you_sure?
        super
      end

      private

      def command
        ::Vault.logical.write(secrets_full_storage_key, SECRETS_FIELD => secrets)
        secrets
      end

      def are_you_sure?
        prompt.yes?("Are you sure you want to write #{secrets_file} to #{secrets_full_storage_key}", default: 'Y')
      end
    end
  end
end
