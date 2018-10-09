require 'net/smtp'

module Net
  class SMTP
    class Proxy < SMTP
      VERSION = '1.0.0'
    end
  end
end
