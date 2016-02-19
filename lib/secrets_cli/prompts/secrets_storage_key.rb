module SecretsCli
  module Prompts
    class SecretsStorageKey
      include SecretsCli::Helpers

      def call
        prompt.ask('What will the secrets storage key be?', default: default)
      end

      private

      def default
        "rails/#{Dir.pwd.split('/').last}/"
      end
    end
  end
end
