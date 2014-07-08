config = RubyJperf.configuration

threads name: 'Localhost', count: 1, loop: 10 do
  visit name: 'Home Page', url: config.host
end
