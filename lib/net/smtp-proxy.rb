require 'net/smtp'
require 'proxifier'

module Net
  module SMTPProxy
    autoload :DeliveryMethod, 'net/smtp-proxy/delivery_method'
    autoload :Proxy,          'net/smtp-proxy/proxy'
  end
end
