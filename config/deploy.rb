require "rvm/capistrano"      # Load RVM's capistrano plugin.
require "bundler/capistrano"  # automagically does the bundle install on deploy

set :application, "adopt-a-sidewalk"
set :repository,  "git://github.com/cfachicago/adopt-a-sidewalk.git"
set :branch,      "master"

set :scm, :git
set :deploy_via, :remote_cache
set :deploy_to,  '/var/www/adopt-a-sidewalk'
set :use_sudo, false
set :user, 'adopt'

set :rvm_type, :system

server "adoptasidewalk.org", :web, :app, :db, :primary => true

before 'deploy:finalize_update', 'deploy:link_db_config'

set :default_environment, { 'GMAPS_KML_ENDPOINT' => "adoptasidewalk.org" }  # FIXME: this is a bit unelegant.

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :link_db_config do
    run "ln -s #{deploy_to}/shared/database.yml #{release_path}/config/database.yml"
  end
end