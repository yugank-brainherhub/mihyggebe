# require 'mina/multistage'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

# set :stages_dir, 'config/deploy_stages'
# set :default_stage, 'staging'
# set :stages, %w(staging)
set :application_name, 'Mihygge-BE'
set :user, 'ubuntu'
set :forward_agent, true     # SSH forward_agent.

set :domain, 'ec2-3-82-217-160.compute-1.amazonaws.com'
set :deploy_to, '/home/ubuntu'
set :repository, 'git@github.com:westagilelabs/Mihygge-BE.git'
set :branch, 'dev'
set :identity_file, 'tmp/myhiggs-staging.pem'
set :rails_env, 'staging'

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`

set :shared_dirs, fetch(:shared_dirs, []).push('tmp/pids','tmp/sockets')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key')

task :remote_environment do
  invoke :'rvm:use', 'ruby-2.6.3'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
# task :setup do
#   # command %[touch "#{fetch(:shared_path)}/config/puma.rb"]
#   # command %{rbenv install 2.3.0 --skip-existing}
# end
task :setup do
  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/secrets.yml"]
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    comment "Deploying #{fetch(:application_name)} to #{fetch(:domain)}:#{fetch(:deploy_to)}"
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'
    
    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end

end

# For help in making your deploy script, see the Mina documentation:
#  - https://github.com/mina-deploy/mina/tree/master/docs