require 'yaml'

module RubyJperf
  class Configuration

    DEFAULT_FILE_PATTERN = '**/*_perf.rb'

    attr_accessor :paths, :host, :port, :jmeter,
                  :filename_pattern

    class << self
      def configure &block
        configuration = new
        yield configuration if block_given?
        configuration
      end
    end

    def initialize options = {}
      options.symbolize_keys!
      @filename_pattern = options[:filename_pattern] || DEFAULT_FILE_PATTERN
      @paths            = options[:paths] || []
      @host             = options[:host]
      @port             = options[:port]
      @jmeter           = options[:jmeter]
    end

    def files_to_run
      results = []
      paths.each do |path|
        if File.directory?(path)
          filename_pattern.split(',').each do |pattern|
            results += Dir[File.expand_path("#{path}/#{pattern.strip}")]
          end
        elsif File.file?(path)
          results << path
        else
          raise "File or directory not found: #{path}"
        end
      end
      results
    end

  end
end
