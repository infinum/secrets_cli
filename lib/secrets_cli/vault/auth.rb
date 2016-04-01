module SecretsCli
  module Vault
    class Auth < SecretsCli::Vault::Base
      include SecretsCli::Helpers

      def initialize(options)
        super
        SecretsCli::Check::Vault.new(options).call
        @auth_method = ENV['VAULT_AUTH_METHOD']
        @auth_token = ENV['VAULT_AUTH_TOKEN']
        @auth_app_id = ENV['VAULT_AUTH_APP_ID']
        @auth_user_id = ENV['VAULT_AUTH_USER_ID']
      end

      private

      attr_reader :auth_token, :auth_method, :auth_app_id, :auth_user_id

      def command
        case auth_method
        when 'github'
          ::Vault.auth.github(auth_token).auth[:policies]
        when 'token'
          ::Vault.auth.token(auth_token).auth[:policies]
        when 'app_id'
          ::Vault.auth.app_id(auth_app_id, auth_user_id).auth[:policies]
        else
          error! "Unknown auth method #{auth_method}"
        end
      end
    end
  end
end
