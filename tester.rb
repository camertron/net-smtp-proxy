require 'bundler/inline'

gemfile do
  source 'http://rubygems.org'

  gem 'mail'
  gem 'net-smtp-proxy', path: '.'
end

require 'mail'
require 'net/smtp/proxy'

Mail.deliver do
  delivery_method Net::SMTP::Proxy::DeliveryMethod, {
    address: 'smtp-relay.gmail.com',
    port: 587,
    proxy_address: 'http://172.16.1.219',
    proxy_port: 3128,
    domain: 'lumoslabs.com'
  }

  from    'platform@lumoslabs.com'
  to      'cameron@lumoslabs.com'
  subject 'Testing'
  body    'This is a test, and it worked!'
end
