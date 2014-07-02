require 'ruby-jmeter'

module RubyJperf

  autoload :Version, 'ruby-jperf/version'
  autoload :Runner,  'ruby-jperf/runner'
  autoload :Options, 'ruby-jperf/options'

  extend Runner
    
end
