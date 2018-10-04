require 'net/smtp'
require 'proxifier'

module Net
  module SMTPProxy
    class Proxy < SMTP
      attr_reader :proxy_address, :proxy_port

      def initialize(address, port, proxy_address, proxy_port)
        super(address, port)
        @proxy_address = proxy_address
        @proxy_port = proxy_port
      end

      private

      def tcp_socket(address, port)
        Proxifier::Proxy("#{proxy_address}:#{proxy_port}").open(address, port)
      end
    end
  end
end
