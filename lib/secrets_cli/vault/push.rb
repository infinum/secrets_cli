module SecretsCli
  module Vault
    class Push < SecretsCli::Vault::Base
      attr_reader :secrets_repo, :secrets_field, :secrets, :secrets_file

      def initialize(options)
        super
        @secrets_repo = options.secrets_repo || config.secrets_repo
        @secrets_field = options.secrets_field || config.secrets_field
        @secrets_file = options.secrets_file || config.secrets_file
        @secrets = File.read(secrets_file)
      end

      def call
        return if !options.without_prompt && !are_you_sure?
        super
      end

      private

      def command
        "vault write #{secrets_full_repo} #{secrets_field}=\"#{secrets}\""
      end

      def are_you_sure?
        prompt.yes?("Are you sure you want to write #{secrets_file} to #{secrets_full_repo}", default: 'Y')
      end
    end
  end
end
