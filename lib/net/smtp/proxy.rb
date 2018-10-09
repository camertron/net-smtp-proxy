require 'net/smtp'
require 'proxifier'

module Net
  class SMTP
    class Proxy < SMTP
      autoload :DeliveryMethod, 'net/smtp/proxy/delivery_method'

      attr_reader :proxy_address, :proxy_port

      class << self
        def start(address, port = nil, proxy_address = nil, proxy_port = nil,
                  helo = 'localhost', user = nil, secret = nil, authtype = nil, &block)
          new(address, port, proxy_address, proxy_port).start(helo, user, secret, authtype, &block)
        end
      end

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
