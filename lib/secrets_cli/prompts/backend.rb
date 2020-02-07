module SecretsCli
  module Prompts
    class Backend
      include SecretsCli::Helpers

      def call
        prompt.ask('What is the vault backend? (logical or kv)', default: 'logical')
      end
    end
  end
end
