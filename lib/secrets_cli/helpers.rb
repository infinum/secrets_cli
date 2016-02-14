module SecretsCli
  module Helpers
    def prompt
      @prompt ||= TTY::Prompt.new
    end

    def pastel
      @pastel ||= Pastel.new
    end

    def config
      @config ||= SecretsCli::Configuration.new(options)
    end

    def error!(message)
      prompt.error(message)
      exit 1
    end

    def print_verbose(message)
      puts pastel.cyan(message)
    end
  end
end
