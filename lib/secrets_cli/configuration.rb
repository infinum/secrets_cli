module SecretsCli
  class Configuration
    attr_reader :environment, :verbose

    def initialize(options)
      @environment = options.environment || ENV['RAILS_ENV'] || 'development'
      @verbose = options.verbose
    end

    def config
      @config ||= YAML.load_file(SECRETS_CONFIG_FILE)
    end

    def secrets_file
      config[:secrets_file]
    end

    def secrets_storage_key
      config[:secrets_storage_key]
    end

    def self.write(config)
      File.open(SECRETS_CONFIG_FILE, 'w') { |f| f.write(config.to_yaml) }
    end
  end
end
