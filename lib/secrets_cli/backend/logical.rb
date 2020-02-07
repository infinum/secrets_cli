module SecretsCli
  module Backend
    class Logical
      attr_reader :client

      def initialize(vault)
        @client = vault.logical
      end

      def list(path)
        client.list(path)
      end

      def read(path)
        client.read(path)
      end

      def write(path, data)
        client.write(path, data)
      end
    end
  end
end
