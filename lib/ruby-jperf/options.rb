require 'active_support/core_ext'

module RubyJperf
  class Options

    DEFAULT_FILE_PATTERN = '**/*_perf.rb'

    attr_accessor :paths, :host, :port, :jmeter, :title,
                  :filename_pattern

    def initialize options = {}, &block
      options.symbolize_keys!
      @filename_pattern = options.fetch(:filename_pattern, DEFAULT_FILE_PATTERN)
      @title            = options.fetch(:title, "JPerf Run #{Time.now}")
      @paths            = options.fetch(:paths, [])
      @host             = options.fetch(:host, nil)
      @port             = options.fetch(:port, nil)
      @jmeter           = options.fetch(:jmeter, {}).symbolize_keys
      yield self if block_given?
    end

  end
end
