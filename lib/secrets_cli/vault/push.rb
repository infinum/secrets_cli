module SecretsCli
  module Vault
    class Push < SecretsCli::Vault::Base
      attr_reader :secrets_storage_key, :secrets_field, :secrets, :secrets_file

      def initialize(options)
        super
        SecretsCli::Check::Secrets.new(:push, options).call
        @secrets_storage_key = options.secrets_storage_key || config.secrets_storage_key
        @secrets_file = options.secrets_file || config.secrets_file
        @secrets = File.read(secrets_file)
      end

      def call
        return if !options.ci_mode && !are_you_sure?
        compare unless options.ci_mode
        super
      end

      private

      def command
        ::Vault.logical.write(secrets_full_storage_key, SECRETS_FIELD => secrets)
        secrets
      end

      def compare
        secrets = ::Vault.logical.read(secrets_full_storage_key)
        secrets = secrets.nil? ? ' ' : secrets.data[SECRETS_FIELD]
        diff = TTY::File.diff(secrets, secrets_file, verbose: false)
        return if diff == ''
        prompt.ok("There are some differences between #{secrets_file} and vault:")
        pretty_diff(diff)
        exit 0 unless prompt.yes?("Are you sure you want to override #{secrets_full_storage_key}?")
      end

      def are_you_sure?
        prompt.yes?("Are you sure you want to write #{secrets_file} to #{secrets_full_storage_key}")
      end
    end
  end
end
