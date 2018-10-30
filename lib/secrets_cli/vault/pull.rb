module SecretsCli
  module Vault
    class Pull < SecretsCli::Vault::Read
      attr_reader :secrets_file, :secrets_dir

      def initialize(options)
        super
        SecretsCli::Check::Secrets.new(:pull, options).call
        @secrets_file = options.secrets_file || config.secrets_file
        @secrets_dir = options.secrets_dir || '.'
      end

      private

      def command
        secrets = super
        compare(secrets_file, secrets) unless options.ci_mode
        write(secrets)
        secrets
      end

      def write(secrets)
        print_verbose("Writing to #{secrets_file}")
        File.open(secrets_path, 'w') { |file| file.write(secrets) }
        File.chmod(0600, secrets_path)
      end

      def secrets_path
        @secrets_path ||= File.join(secrets_dir, secrets_file)
      end
    end
  end
end
