module SecretsCli
  module Vault
    class Auth < SecretsCli::Vault::Base
      include SecretsCli::Helpers

      def initialize(options)
        super
        @auth_token = options.auth_token || ENV['_VAULT_AUTH_TOKEN']
        @auth_method = options.auth_method || ENV['VAULT_AUTH_METHOD']
      end

      private

      attr_reader :auth_token, :auth_method

      def command
        case auth_method
        when 'github'
          "vault auth -method=github token=#{auth_token}"
        when 'token'
          "vault auth #{auth_token}"
        else
          error! "Unknown auth method #{auth_method}"
        end
      end
    end
  end
end
