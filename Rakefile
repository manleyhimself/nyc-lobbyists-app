# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

NycLobbyistsApp::Application.load_tasks

task :environment => :disable_initializer

task :disable_initializer do
   ENV['DISABLE_INITIALIZER_FROM_RAKE'] = 'true'
end
