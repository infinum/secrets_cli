module SecretsCli
  module Check
    class Vault
      include SecretsCli::Helpers

      attr_reader :options

      def initialize(options)
        @options = options
      end

      def call
        error! 'Missing vault' if TTY::Which.which('vault').nil?
        error! 'Missing VAULT_ADDR env' if ENV['VAULT_ADDR'].nil?
        error! 'Missing VAULT_AUTH_TOKEN env' if missing_auth_token?
        error! 'Missing VAULT_AUTH_METHOD env' if missing_auth_method?
      end

      private

      def missing_auth_token?
        options.auth_token.nil? && ENV['VAULT_AUTH_TOKEN'].nil?
      end

      def missing_auth_method?
        options.auth_method.nil? && ENV['VAULT_AUTH_METHOD'].nil?
      end
    end
  end
end
