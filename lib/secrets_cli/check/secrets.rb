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
        error! 'Missing secrets_repo' if missing_secret_repo?
        error! 'Missing secrets_field' if missing_secret_field?
      end

      private

      def missing_secret_file?
        options.secrets_file.nil? && config.secrets_file.nil?
      end

      def missing_secret_repo?
        options.secrets_repo && config.secrets_repo.nil?
      end

      def missing_secret_field?
        options.secrets_field && config.secrets_field.nil?
      end
    end
  end
end
