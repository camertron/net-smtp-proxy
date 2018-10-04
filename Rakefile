$LOAD_PATH.push('./lib')

require 'rake'
require 'rspec/core/rake_task'
require 'rubygems/package_task'

task default: %i[spec]

desc 'Run all rspec files'
RSpec::Core::RakeTask.new('spec')
