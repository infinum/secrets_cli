module SecretsCli
  module Check
    class Secrets
      include SecretsCli::Helpers

      attr_reader :action
      attr_reader :options

      def initialize(action, options)
        @action = action
        @options = options
      end

      def call
        error! 'Missing .secrets' unless File.exist?('.secrets')
        error! 'Missing secrets_file' if require_secrets_file? && missing_secret_file?
        error! 'Missing secrets_storage_key' if missing_secret_storage_key?
      end

      private

      def missing_secret_file?
        options.secrets_file.nil? && config.secrets_file.nil?
      end

      def require_secrets_file?
        ![:read, :edit].include?(action)
      end

      def missing_secret_storage_key?
        options.secrets_storage_key && config.secrets_storage_key.nil?
      end
    end
  end
end
