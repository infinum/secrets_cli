module SecretsCli
  module Check
    class Vault
      include SecretsCli::Helpers

      attr_reader :options

      def initialize(options)
        @options = options
      end

      def call
        error! 'Missing VAULT_ADDR env' if ENV['VAULT_ADDR'].nil?
        error! 'Missing VAULT_AUTH_METHOD env' if missing_auth_method?
        if auth_method == 'app_id'
          error! 'Missing VAULT_AUTH_APP_ID' if missing_auth_app_id?
          error! 'Missing VAULT_AUTH_USER_ID' if missing_auth_user_id?
        else
          error! 'Missing VAULT_AUTH_TOKEN env' if missing_auth_token?
        end
      end

      private

      def missing_auth_token?
        options.auth_token.nil? && ENV['VAULT_AUTH_TOKEN'].nil?
      end

      def missing_auth_method?
        options.auth_method.nil? && ENV['VAULT_AUTH_METHOD'].nil?
      end

      def missing_auth_app_id?
        options.auth_app_id.nil? && ENV['VAULT_AUTH_APP_ID'].nil?
      end

      def missing_auth_user_id?
        options.auth_user_id.nil? && ENV['VAULT_AUTH_USER_ID'].nil?
      end

      def auth_method
        ENV['VAULT_AUTH_METHOD']
      end
    end
  end
end
