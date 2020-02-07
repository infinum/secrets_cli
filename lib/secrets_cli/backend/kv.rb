module SecretsCli
  module Backend
    class KV
      attr_reader :version, :client

      def initialize(vault, mount, version = nil)
        @client = vault.kv(mount)
        @version = version
      end

      def list(path)
        client.list(path)
      end

      def read(path)
        client.read(path, version)
      end

      def write(path, data)
        client.write(path, data)
      end
    end
  end
end
