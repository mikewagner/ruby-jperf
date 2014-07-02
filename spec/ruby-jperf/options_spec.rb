require 'spec_helper'

describe RubyJperf::Options do

  describe 'initialization' do
    context 'with no options' do

      subject(:options) { RubyJperf::Options.new }

      it 'defaults paths' do
        expect(options.paths).to eq([])
      end

      it 'defaults filename pattern' do
        expect(options.filename_pattern).to eq('**/*_perf.rb')
      end

      it 'defaults title' do
        expect(options.title).to match(/^JPerf Run/)
      end
    end

    context 'with options' do

      subject(:options) {
        RubyJperf::Options.new(:paths => 'examples',
                                     :jmeter_path => '/usr/share/bin/jmeter/',
                                     :title => 'This is the title',
                                     :filename_pattern => '**/*_foo.rb')
      }

      it 'sets paths' do
        expect(options.paths).to eq('examples')
      end

      it 'sets filename pattern path' do
        expect(options.filename_pattern).to eq('**/*_foo.rb')
      end

      it 'sets title' do
        expect(options.title).to eq('This is the title')
      end
    end

    context 'initializing with block' do
      subject(:options) do
        RubyJperf::Options.new do |options|
          options.paths = 'examples'
          options.filename_pattern = '**/*_foo.rb'
          options.title = 'This is a test title'
        end
      end
      it 'sets paths' do
        expect(options.paths).to eq('examples')
      end

      it 'sets filename pattern path' do
        expect(options.filename_pattern).to eq('**/*_foo.rb')
      end

      it 'sets title' do
        expect(options.title).to eq('This is a test title')
      end
    end
  end
end
