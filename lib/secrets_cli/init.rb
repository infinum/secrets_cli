module SecretsCli
  class Init
    include SecretsCli::Helpers

    attr_reader :options

    def initialize(options)
      @options = options
    end

    def call
      SecretsCli::Configuration.write(config)
      prompt.ok "Written in #{SECRETS_CONFIG_FILE}:"
      prompt.ok File.read(SECRETS_CONFIG_FILE)
    end

    private

    def config
      {
        secrets_file: secrets_file,
        secrets_storage_key: secrets_storage_key
      }
    end

    def secrets_file
      @secrets_file ||= options.secrets_file || SecretsCli::Prompts::SecretsFile.new.call
    end

    def secrets_storage_key
      storage_key = options.secrets_storage_key || SecretsCli::Prompts::SecretsStorageKey.new.call
      storage_key << '/' unless storage_key.end_with?('/')
      storage_key
    end
  end
end
