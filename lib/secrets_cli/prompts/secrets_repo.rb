module SecretsCli
  module Prompts
    class SecretsRepo
      include SecretsCli::Helpers

      def call
        prompt.ask('What will the secrets repo be?', default: default)
      end

      private

      def default
        "rails/#{Dir.pwd.split('/').last}/"
      end
    end
  end
end
