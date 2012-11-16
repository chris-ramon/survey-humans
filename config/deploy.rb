# be sure to change these
set :user, 'ubuntu'
set :domain, '23.21.44.56'
set :application, "surveyhumans"

# file paths
set :repository,  "#{user}@#{domain}:git/#{application}.git"
set :deploy_to, "/home/#{user}/#{domain}"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :app, domain                          # This may be the same as your `Web` server
role :web, domain                          # Your HTTP server, Apache/etc
role :db,  domain, :primary => true 				# This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
ssh_options[:forward_agent] = true
default_run_options[:pty] = true
# miscellaneous options
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false

namespace :deploy do
	desc "cause Passenger to initiate a restart" 
	task :restart do
    run "touch #{current_path}/tmp/restart.txt"
	end
	desc "reload the database with seed data" 
	task :db_migrate do
    run "cd #{current_path}; rake db:migrate RAILS_ENV=production"
  end
  desc "insert basic data"
  task :db_seeds do
    puts "=== Inserting basic data ==="
    files = ["01_access", "02_profile", "03_user", "04_company", "05_match", "06_match_type",
             "07_question_level", "08_question_type", "09_question", "10_answer", "11_answer_format",
             "13_insert_plans"]
    files.each do |file_name|
      run "cd #{current_path}; rake db:seed:#{file_name} RAILS_ENV=production"
    end
  end
end
after "deploy:update_code", :bundle_install 
	desc "install the necessary prerequisites" 
	task :bundle_install, :roles => :app do
  run "cd #{current_path} && bundle install --without development test"
  end
#release_path