require 'spec_helper'

describe RubyJperf::Configuration do

  describe 'initialization' do
    context 'with no options' do

      subject(:config) { RubyJperf::Configuration.new }

      it 'defaults paths' do
        expect(config.paths).to eq([])
      end

      it 'defaults filename pattern' do
        expect(config.filename_pattern).to eq('**/*_perf.rb')
      end

      it 'defaults title' do
        expect(config.title).to match(/^JPerf Run/)
      end
    end

    context 'with options' do

      subject(:config) {
        RubyJperf::Configuration.new(:paths => 'examples',
                                     :jmeter_path => '/usr/share/bin/jmeter/',
                                     :title => 'This is the title',
                                     :filename_pattern => '**/*_foo.rb')
      }

      it 'sets paths' do
        expect(config.paths).to eq('examples')
      end

      it 'sets filename pattern path' do
        expect(config.filename_pattern).to eq('**/*_foo.rb')
      end

      it 'sets title' do
        expect(config.title).to eq('This is the title')
      end
    end

    context 'initializing with block' do
      subject(:config) do
        RubyJperf::Configuration.configure do |config|
          config.paths = 'examples'
          config.filename_pattern = '**/*_foo.rb'
          config.title = 'This is a test title'
        end
      end
      it 'sets paths' do
        expect(config.paths).to eq('examples')
      end

      it 'sets filename pattern path' do
        expect(config.filename_pattern).to eq('**/*_foo.rb')
      end

      it 'sets title' do
        expect(config.title).to eq('This is a test title')
      end
    end
  end

  describe '#files_to_run' do
    let(:config) { RubyJperf::Configuration.new }

    it 'loads files when named explicitly' do
      file = File.expand_path(File.dirname(__FILE__) + "/../resources/a_foo.rb")
      config.paths = [file]
      expect(config.files_to_run).to include(file)
    end

    it 'loads files that match patterns' do
      dir = File.expand_path(File.dirname(__FILE__) + "/../resources/")
      config.paths = [dir]
      config.filename_pattern = '**/*_foo.rb,**/*_bar.rb'
      expect(config.files_to_run).to include("#{dir}/a_foo.rb")
      expect(config.files_to_run).to include("#{dir}/a_bar.rb")
    end
  end
end
