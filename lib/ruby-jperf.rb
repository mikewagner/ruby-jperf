require 'ruby-jmeter'
require 'active_support/core_ext'

module RubyJperf

  autoload :Version,       'ruby-jperf/version'
  autoload :Configuration, 'ruby-jperf/configuration'
  autoload :Jmeter,        'ruby-jperf/jmeter.rb'
  autoload :Runner,        'ruby-jperf/runner'

end
