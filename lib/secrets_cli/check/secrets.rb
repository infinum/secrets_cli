module SecretsCli
  module Check
    class Secrets
      include SecretsCli::Helpers

      attr_reader :options

      def initialize(options)
        @options = options
      end

      def call
        error! 'Missing .secrets' unless File.exist?('.secrets')
        error! 'Missing secrets_file' if missing_secret_file?
        error! 'Missing secrets_storage_key' if missing_secret_storage_key?
      end

      private

      def missing_secret_file?
        options.secrets_file.nil? && config.secrets_file.nil?
      end

      def missing_secret_storage_key?
        options.secrets_storage_key && config.secrets_storage_key.nil?
      end
    end
  end
end
