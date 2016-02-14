module SecretsCli
  module Vault
    class Pull < SecretsCli::Vault::Read
      attr_reader :secrets_file

      def initialize(options)
        super
        @secrets_file = options.secrets_file || config.secrets_file
      end

      def call
        secrets = super.first
        print_verbose("Writing to #{secrets_file}")
        File.open(secrets_file, 'w') { |f| f.write(secrets) }
      end
    end
  end
end
