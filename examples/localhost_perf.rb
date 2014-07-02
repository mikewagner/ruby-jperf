config = RubyJperf.configuration

threads count: 1, loop: 10 do
  visit name: 'Home Page', url: config.host
end
