## net-smtp-proxy
Proxy support for Ruby's Net::SMTP library.

## Installation

`gem install net-smtp-proxy`

or put it in your Gemfile:

```ruby
gem 'net-smtp-proxy'
```

Once it's available in your project, require it like so:

```ruby
require 'net/smtp/proxy'
```

### What is this Thing?

This gem allows you to connect to an SMTP server by way of an HTTP proxy. Why would you want to do that? I'm sure a number of use-cases exist, but I specifically needed to connect to the Gmail SMTP relay service in order to send an email from a company-wide alias. Normally, Gmail requires you to provide the credentials for the sender's account when sending an email. The relay service however replaces the usual password authentication with IP whitelisting. You provide Google with a static IP address that all your SMTP requests will come from. The SMTP relay service also allows you to send email from company-wide email aliases, i.e. accounts that don't have a login. In our case, we wanted to send an email from the Platform Engineering Team as opposed to one specific member of that team. We already had [Squid](http://www.squid-cache.org/) set up as a [reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy) with a static IP, so we whitelisted the IP with Google and wrote this gem to send SMTP requests through the proxy.

### Usage

Instantiate an instance of the `Proxy` class and use it to make SMTP requests:

```ruby
address = 'smtp-relay.gmail.com'
port = 587
proxy_address = 'http://myproxy.mydomain.com'
proxy_port = 1234

proxy = Net::SMTP::Proxy.new(address, port, proxy_address, proxy_port)

proxy.start do |smtp|
  smtp.helo('mydomain.com')
end
```

You can also use the `.start` method to accomplish the same thing:

```ruby
Net::SMTP::Proxy.start(address, port, proxy_address, proxy_port) do |smtp|
  smtp.helo('mydomain.com')
end
```

### Integration with the Mail Gem

The `DeliveryMethod` class provides an easy way to integrate with the [Mail gem](https://github.com/mikel/mail). Simply pass the class in as the delivery method, providing the same options hash you would pass to the SMTP delivery method (plus the proxy options):

```ruby
Mail.deliver do
  delivery_method Net::SMTP::Proxy::DeliveryMethod, {
    address: address,
    port: port,
    proxy_address: proxy_address,
    proxy_port: proxy_port,
    domain: 'mydomain.com'
  }

  from    'from@mydomain.com'
  to      'to@mydomain.com'
  subject 'Mail is cool'
  body    "Look ma, I'm sending email!"
end
```

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
