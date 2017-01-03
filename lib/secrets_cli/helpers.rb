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

    def error(message)
      prompt.error(message)
      exit 0
    end

    def print_verbose(message)
      puts pastel.cyan(message)
    end

    def pretty_diff(diff)
      diff.each_line do |line|
        case line[0]
        when '+' then prompt.ok(line, newline: false)
        when '-' then prompt.error(line, newline: false)
        else
          puts line
        end
      end
      puts
    end
  end
end
