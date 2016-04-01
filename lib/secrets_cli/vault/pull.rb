module SecretsCli
  module Vault
    class Pull < SecretsCli::Vault::Read
      attr_reader :secrets_file, :secrets_dir

      def initialize(options)
        super
        SecretsCli::Check::Secrets.new(options).call
        @secrets_file = options.secrets_file || config.secrets_file
        @secrets_dir = options.secrets_dir || '.'
      end

      private

      def command
        secrets = super
        print_verbose("Writing to #{secrets_file}")
        File.open(File.join(secrets_dir, secrets_file), 'w') { |file| file.write(secrets) }
        secrets
      end
    end
  end
end
