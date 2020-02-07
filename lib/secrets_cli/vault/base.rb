module SecretsCli
  module Vault
    class Base
      include SecretsCli::Helpers

      attr_reader :options

      def initialize(options)
        @options = options
      end

      def call(verbose: false)
        verbose ? prompt.ok(command).first : command
      rescue => exception
        # require 'pry'; binding.pry
        error!(exception.message)
      end

      private

      def command
        raise NotImplementedError
      end

      def vault
        @vault ||=
          ::Vault::Client.new(
            address: config.vault_addr,
            token: SecretsCli::Vault::Auth.new(options).call
          )
      end

      def backend
        @backend ||= 
          case config.backend
          when 'logical' then SecretsCli::Backend::Logical.new(vault)
          when 'kv' then SecretsCli::Backend::KV.new(vault, config.mount, options.kv_version)
          end
      end

      def secrets_full_storage_key
        File.join(secrets_storage_key, config.environment.to_s)
      end

      def compare(first, second)
        diff = TTY::File.diff(first, second, verbose: false)
        return if diff == ''

        prompt.ok('There are some differences:')
        pretty_diff(diff)
        exit 0 unless prompt.yes?('Are you sure you want to override?')
      end
    end
  end
end
