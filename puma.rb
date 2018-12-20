PATH = File.expand_path(File.dirname(__FILE__))

environment 'production'

bind 'unix://' + PATH + '/tmp/sockets/puma.sock'

pidfile PATH + '/tmp/pids/puma.pid'
state_path PATH + '/tmp/pids/puma.state'

workers 0
threads 1, 1
