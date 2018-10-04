begin
  require 'mail'
rescue LoadError
  puts 'The mail gem is required to use the DeliveryMethod class.'
end

module Net
  module SMTPProxy
    # for use with the mail gem
    class DeliveryMethod < ::Mail::SMTP
      private

      # adapted from
      # https://github.com/mikel/mail/blob/6bc16b4bce4fe280b19523c939b14a30e32a8ba4/lib/mail/network/delivery_methods/smtp.rb#L112
      def build_smtp_session
        init_params = [
          settings[:address], settings[:port],
          settings[:proxy_address], settings[:proxy_port]
        ]

        Net::SMTPProxy.new(*init_params).tap do |smtp|
          if settings[:tls] || settings[:ssl]
            if smtp.respond_to?(:enable_tls)
              smtp.enable_tls(ssl_context)
            end
          elsif settings[:enable_starttls]
            if smtp.respond_to?(:enable_starttls)
              smtp.enable_starttls(ssl_context)
            end
          elsif settings[:enable_starttls_auto]
            if smtp.respond_to?(:enable_starttls_auto)
              smtp.enable_starttls_auto(ssl_context)
            end
          end

          smtp.open_timeout = settings[:open_timeout] if settings[:open_timeout]
          smtp.read_timeout = settings[:read_timeout] if settings[:read_timeout]
        end
      end
    end
  end
end
