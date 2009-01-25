application = ENV['F1_SERVER_IP']
port = ENV['F1_SERVER_PORT']
user = ENV['F1_DEPLOY_USER']
deploy_to = '/var/www/apps/f1.ruby.mn'

set :application, application
set :user, user
set :port, port
 
set :deploy_to, deploy_to
 
role :app, application
role :web, application
role :db,  application, :primary => true
 
#############################################################
#  Github
#############################################################
 
github_account = "andyatkinson"
set :scm, "git"
default_run_options[:pty] = true
set :repository,  "git@github.com:#{github_account}/f1-2009.git"
 
set :ssh_options, { :forward_agent => true }
set :branch, "master"
 
# set deploy to copy to local first, then upload
set :deploy_via, :copy
set :runner, user
 
#############################################################
#  Passenger
#############################################################
 
deploy.task :start do 
  # nothing 
end
 
task :restart, :roles => :app do
  run "touch #{current_path}/tmp/restart.txt"
end
 
after :deploy, 'restart'