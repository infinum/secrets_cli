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
        secrets_repo: secrets_repo,
        secrets_field: secrets_field
      }
    end

    def secrets_file
      @secrets_file ||= options.secrets_file || SecretsCli::Prompts::SecretsFile.new.call
    end

    def secrets_repo
      repo = options.secrets_repo || SecretsCli::Prompts::SecretsRepo.new.call
      repo << '/' unless repo.end_with?('/')
      repo
    end

    def secrets_field
      options.secrets_field || SecretsCli::Prompts::SecretsField.new.call
    end
  end
end
