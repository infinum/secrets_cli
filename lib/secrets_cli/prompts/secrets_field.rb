module SecretsCli
  module Prompts
    class SecretsField
      include SecretsCli::Helpers

      def call
        prompt.ask('What will the secrets key be?', default: 'secrets')
      end
    end
  end
end
