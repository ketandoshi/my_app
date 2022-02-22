# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "my_app_hello"
set :repo_url, "git@github.com:ketandoshi/my_app.git"

set :rvm_ruby_version, '2.6.6'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh
set :format, :pretty

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true
set :use_sudo, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/master.key', 'config/credentials.yml.enc')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 10

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :conditionally_migrate, true

namespace :deploy do

  task :migrate do
    on roles(:db) do
      within "#{fetch(:deploy_to)}/current/" do
        with RAILS_ENV: fetch(:environment) do
          execute :rake, "db:migrate"
        end
      end
    end
  end

  task :restart do
    on roles(:web) do
      within "#{fetch(:deploy_to)}/current/" do
        execute "sudo service nginx reload"
      end
    end
  end

  task :execute_onetimer, :task_name do |t, args|
    on roles(:script) do
      within "#{fetch(:deploy_to)}/current/" do
        with RAILS_ENV: fetch(:environment) do
          execute :rake, args[:task_name]
        end
      end
    end
  end

end