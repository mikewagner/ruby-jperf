module RubyJperf
  module Runner

    def configure params = {}, &block
      @options = RubyJperf::Options.new(params)
      yield @options if block_given?
      self
    end

    def configuration
      @options ||= RubyJperf::Options.new
    end

    def files_to_run
      results = []
      configuration.paths.each do |path|
        if File.directory?(path)
          configuration.filename_pattern.split(',').each do |pattern|
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

    def run
      tests = []
      files_to_run.each do |file|
        tests << File.read(file)
      end

      plan = test name: configuration.title do
        eval(tests.join("\n"))
      end

      plan.run(configuration.jmeter)
    end

  end
end
