module RubyJperf
  class Runner
  
    attr_accessor :config
      
    def initialize config
      @config = config
    end

    def run
      config.files_to_run.each do |file|
        code = File.read(file)
      end 
    end

  end
end
