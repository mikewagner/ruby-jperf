module RubyJperf
  class Configuration

    attr_accessor :paths,
                  :filename_pattern,
                  :jmeter_path

    class << self
      def configure &block
        configuration = new
        yield configuration if block_given?
        configuration
      end
    end

    def initialize options = {}
      @paths            = options[:paths] || []
      @jmeter_path      = options[:jmeter_path] || '/usr/local/bin/jmeter/bin/'
      @filename_pattern = options[:filename_pattern] || '**/*_perf.rb'
    end

    def files_to_run
      results = []
      paths.each do |path|
        if File.directory?(path)
          filename_pattern.split(",").each do |pattern|
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
