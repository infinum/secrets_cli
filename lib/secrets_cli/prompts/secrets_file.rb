module SecretsCli
  module Prompts
    class SecretsFile
      include SecretsCli::Helpers

      def call
        case choice
        when 1 then 'config/application.yml'
        when 2 then '.env'
        when 3 then prompt.ask('What secrets file are you using?', required: true)
        end
      end

      private

      def choice
        prompt.select('Which secrets gem are you using?') do |menu|
          menu.choice 'Figaro (config/application.yml)', 1
          menu.choice 'dotenv (.env)', 2
          menu.choice 'other', 3
        end
      end
    end
  end
end
