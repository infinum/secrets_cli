module SecretsCli
  module Vault
    class Read < SecretsCli::Vault::Base
      def initialize(options)
        super
        @secrets_repo = options.secrets_repo || config.secrets_repo
        @secrets_field = options.secrets_field || config.secrets_field
      end

      private

      attr_reader :secrets_repo, :secrets_field

      def command
        "vault read --field=#{secrets_field} #{secrets_full_repo}"
      end
    end
  end
end
