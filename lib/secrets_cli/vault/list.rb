module SecretsCli
  module Vault
    class List < SecretsCli::Vault::Base
      def initialize(options)
        super
        options.default(verbose: !options.ci_mode)
        SecretsCli::Check::Secrets.new(:read, options).call
        @secrets_storage_key = options.secrets_storage_key || config.secrets_storage_key
      end

      private

      attr_reader :secrets_storage_key

      def command
        vault.logical.list(secrets_storage_key).join("\n")
      end
    end
  end
end
