module SecretsCli
  module Prompts
    class VaultAddr
      include SecretsCli::Helpers

      def call
        prompt.ask('What is the vault address? (if not supplied VAULT_ADDR env will be used)')
      end
    end
  end
end
