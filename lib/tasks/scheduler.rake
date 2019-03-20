desc "This task is called by the Heroku scheduler add-on"
task :update_goals => :environment do
  puts "Updating goals..."
      Rake::Task[:master_counter].execute
  puts "done."
end