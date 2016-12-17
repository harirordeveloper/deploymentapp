lock '3.5.0'
set :application, 'testapp'
set :repo_url, 'git@github.com:harirordeveloper/deploymentapp.git'

set :deploy_to, '/home/deploy/testapp'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

