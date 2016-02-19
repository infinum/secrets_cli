module SecretsCli
  module Vault
    class Read < SecretsCli::Vault::Base
      def initialize(options)
        super
        @secrets_storage_key = options.secrets_storage_key || config.secrets_storage_key
      end

      private

      attr_reader :secrets_storage_key

      def command
        "vault read --field=#{SECRETS_FIELD} #{secrets_full_storage_key}"
      end
    end
  end
end
