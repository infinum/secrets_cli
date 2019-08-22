module SecretsCli
  module Vault
    class Policies < SecretsCli::Vault::Base
      def initialize(options)
        super
      end

      private

      attr_reader :secrets_storage_key

      def command
        SecretsCli::Vault::Auth.new(options).call.policies
      end
    end
  end
end
