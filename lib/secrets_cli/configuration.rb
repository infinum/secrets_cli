module SecretsCli
  class Configuration
    attr_reader :environment, :verbose

    def initialize(options)
      @environment = (options.environment || ENV['RAILS_ENV'] || ENV['NODE_ENV'] || 'development').to_sym
      @verbose = options.verbose
    end

    def config
      @config ||=
        Psych.load(File.read(SECRETS_CONFIG_FILE), symbolize_names: true)
    end

    def secrets_file
      fetch(:secrets_file)
    end

    def secrets_storage_key
      fetch(:secrets_storage_key)
    end

    def vault_addr
      fetch(:vault_addr) || ENV['VAULT_ADDR']
    end

    def self.write(config)
      File.open(SECRETS_CONFIG_FILE, 'w') { |file| file.write(config.to_yaml) }
    end

    private

    def fetch(var)
      config.fetch(environment, {}).fetch(var, nil) || config[var]
    end
  end
end
