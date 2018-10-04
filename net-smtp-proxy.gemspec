$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'net/smtp-proxy'

Gem::Specification.new do |s|
  s.name     = 'net-smtp-proxy'
  s.version  = ::Net::SMTPProxy::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron'

  s.description = s.summary = 'Proxy support for Net::SMTP.'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'proxifier', '~> 1.0'

  s.add_development_dependency 'rake', '~> 12'
  s.add_development_dependency 'rspec', '~> 3.5'

  s.require_path = 'lib'
  s.files = Dir[
    '{lib,spec}/**/*', 'Gemfile', 'README.md',
    'Rakefile', 'net-smtp-proxy.gemspec'
  ]
end
