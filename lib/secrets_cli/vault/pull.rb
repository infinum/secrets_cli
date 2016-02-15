module SecretsCli
  module Vault
    class Pull < SecretsCli::Vault::Read
      attr_reader :secrets_file, :secrets_dir

      def initialize(options)
        super
        @secrets_file = options.secrets_file || config.secrets_file
        @secrets_dir = options.secrets_dir || '.'
      end

      def call
        secrets = super.first
        print_verbose("Writing to #{secrets_file}")
        File.open(File.join(secrets_dir, secrets_file), 'w') { |f| f.write(secrets) }
      end
    end
  end
end
