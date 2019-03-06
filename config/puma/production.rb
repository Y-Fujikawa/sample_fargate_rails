root = File.expand_path('../..', __dir__)
directory root
workers `nproc`.to_i
preload_app!
bind 'tcp://0.0.0.0:80'
environment ENV.fetch('RAILS_ENV') { 'production' }
worker_timeout 120
pidfile root + '/tmp/pids/puma.pid'
threads 5, 5
